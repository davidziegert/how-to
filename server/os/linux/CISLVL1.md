# CIS Hardened Image Level 1 on Ubuntu Linux

CIS (Center for Internet Security) Level 1 benchmarks are baseline security configurations that provide a good security posture without significantly impacting system functionality.

---

## 1. Prerequisites

- Ubuntu LTS (20.04, 22.04, or 24.04)
- Root or sudo access
- Backup your system before starting
- Download the [CIS Benchmark PDF](https://www.cisecurity.org/benchmark/ubuntu_linux) for your specific version

---

## 2. Filesystem Configuration

**Disable unused filesystems:**

```bash
# Add to /etc/modprobe.d/cis.conf
cat << 'EOF' > /etc/modprobe.d/cis-hardening.conf
install cramfs /bin/true
install freevxfs /bin/true
install jffs2 /bin/true
install hfs /bin/true
install hfsplus /bin/true
install squashfs /bin/true
install udf /bin/true
install usb-storage /bin/true
EOF
```

**Separate partitions** (best done at install time):

| Mount Point | Options |
|---|---|
| `/tmp` | `nodev,nosuid,noexec` |
| `/var` | separate partition |
| `/var/tmp` | `nodev,nosuid,noexec` |
| `/var/log` | separate partition |
| `/home` | `nodev` |

```bash
# Example /etc/fstab entries
# tmpfs /tmp tmpfs defaults,nodev,nosuid,noexec 0 0
```

---

## 3. Package Management & Updates

```bash
# Enable automatic security updates
apt install -y unattended-upgrades apt-listchanges
dpkg-reconfigure -plow unattended-upgrades

# Remove unnecessary packages
apt purge -y telnet rsh-client rsh-redone-client talk nis
apt autoremove -y
```

---

## 4. Network Configuration

```bash
# Create sysctl hardening file
cat << 'EOF' > /etc/sysctl.d/99-cis-hardening.conf
# Disable IP forwarding
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Disable packet redirect sending
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

# Disable ICMP redirect acceptance
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0

# Enable reverse path filtering
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Ignore ICMP broadcast requests
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Enable TCP SYN cookies
net.ipv4.tcp_syncookies = 1

# Disable IPv6 (if not needed)
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

sysctl -p /etc/sysctl.d/99-cis-hardening.conf
```

---

## 5. SSH Hardening

```bash
# Edit /etc/ssh/sshd_config
cat << 'EOF' >> /etc/ssh/sshd_config.d/99-cis.conf
Protocol 2
PermitRootLogin no
MaxAuthTries 4
IgnoreRhosts yes
HostbasedAuthentication no
PermitEmptyPasswords no
PermitUserEnvironment no
Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
MACs hmac-sha2-256,hmac-sha2-512
KexAlgorithms ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group14-sha256
ClientAliveInterval 300
ClientAliveCountMax 3
LoginGraceTime 60
Banner /etc/issue.net
AllowTcpForwarding no
X11Forwarding no
PrintLastLog yes
EOF

systemctl restart sshd
```

---

## 6. PAM & Password Policy

```bash
# Install password quality library
apt install -y libpam-pwquality

# Edit /etc/security/pwquality.conf
cat << 'EOF' > /etc/security/pwquality.conf
minlen = 14
dcredit = -1
ucredit = -1
lcredit = -1
ocredit = -1
minclass = 4
maxrepeat = 3
EOF

# Set password expiration in /etc/login.defs
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   365/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   1/' /etc/login.defs
sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE   7/' /etc/login.defs
```

---

## 7. Auditing & Logging (auditd)

```bash
apt install -y auditd audispd-plugins

# Basic audit rules
cat << 'EOF' > /etc/audit/rules.d/99-cis.rules
# Log sudo usage
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope

# Log authentication events
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins

# Log privileged commands
-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k setuid
-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -k setuid

# Log file deletions
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -k delete
EOF

systemctl enable auditd
systemctl start auditd
```

---

## 8. File Permissions & Integrity

```bash
# Install AIDE (Advanced Intrusion Detection Environment)
apt install -y aide aide-common

# Initialize the AIDE database
aideinit
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Schedule daily checks
echo "0 5 * * * root /usr/bin/aide --check" >> /etc/crontab

# Fix common permission issues
chmod 644 /etc/passwd
chmod 640 /etc/shadow
chmod 644 /etc/group
chmod 640 /etc/gshadow
chown root:root /etc/passwd /etc/group
chown root:shadow /etc/shadow /etc/gshadow
```

---

## 9. Firewall (UFW)

```bash
apt install -y ufw

ufw default deny incoming
ufw default allow outgoing
ufw allow ssh   # adjust as needed
ufw --force enable
ufw status verbose
```

---

## 10. Cron & At Restrictions

```bash
# Restrict cron to root only
rm -f /etc/cron.deny /etc/at.deny
echo "root" > /etc/cron.allow
echo "root" > /etc/at.allow
chmod 600 /etc/cron.allow /etc/at.allow
chown root:root /etc/cron.allow /etc/at.allow
```

---

## 11. GRUB Bootloader Password

```bash
# Set GRUB superuser password
grub-mkpasswd-pbkdf2  # note the hash output

# Add to /etc/grub.d/40_custom:
# set superusers="root"
# password_pbkdf2 root <hash>

update-grub
```

---

## 12. Automated Tools

Rather than doing this manually, consider these tools:

| Tool | Description |
|---|---|
| **`oscap`** (OpenSCAP) | Scans and auto-remediates against CIS profiles |
| **`CIS-CAT Lite`** | Free CIS scanning tool |
| **`Lynis`** | Security auditing tool |
| **`ansible-hardening`** | Ansible role for CIS compliance |

```bash
# Quick audit with Lynis
apt install -y lynis
lynis audit system

# OpenSCAP scan
apt install -y libopenscap8 ssg-ubuntu2004  # adjust for your version
oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis_level1_server \
  /usr/share/xml/scap/ssg/content/ssg-ubuntu2004-xccdf.xml
```

---

## Key Reminders

- **Always test** in a non-production environment first
- CIS Benchmark PDFs are free to download from [cisecurity.org](https://www.cisecurity.org)
- Level 1 targets **server** and **workstation** profiles separately — pick the right one
- Some controls require decisions (e.g., whether to disable IPv6) based on your environment
- Re-run Lynis or CIS-CAT after changes to measure your score improvement
