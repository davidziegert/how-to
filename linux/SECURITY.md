# How To - Linux - Security (Ubuntu) [^12]

## Automatic Updates

```
sudo apt install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

```
// Unattended-Upgrade::Mail "me@example.com ";
Unattended-Upgrade::Allowed-Origins
{
    "${distro_id} stable";"${distro_id} ${distro_codename}-security";
    "${distro_id} ${distro_codename}-updates";
    "${distro_id}ESMApps:${distro_codename}-apps-security";
    "${distro_id}ESM:${distro_codename}-infra-security";
};
Unattended-Upgrade::DevRelease "false";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "02:00";
```

```
sudo nano /etc/apt/apt.conf.d/20auto-upgrades
```

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```

```
sudo unattended-upgrades --dry-run --debug
```

## SSH 

### Login via Keys [^1] [^2]

#### Server

```
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

#### Client (Windows)

```
cd \Users\user
ssh-keygen -t rsa
type .ssh\id_rsa.pub | ssh user@xxx.xxx.xxx.xxx "cat >> .ssh/authorized_keys"
```

#### Client (Mac/Linux)

```
ssh-keygen -t rsa
ssh-copy-id -i .ssh/id_rsa.pub user@xxx.xxx.xxx.xxx
ssh -i .ssh/id_rsa user@xxx.xxx.xxx.xxx
```

### Configuration [^8] [^9] [^10]

```
sudo cp /etc/ssh/sshd_confi /etc/ssh/sshd_config.original
sudo sshd -T
sudo nano /etc/ssh/sshd_config
```

```
Port 22 -> 54321
PermitRootLogin no
PermitEmptyPasswords no

PasswordAuthentication yes
PubkeyAuthentication yes

MaxAuthTries 3

AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
PrintMotd no
ChallengeResponseAuthentication no
HostbasedAuthentication no
IgnoreRhosts yes
X11Forwarding no
UsePAM yes -> no (if no LDAP)

AllowGroups root
AllowUsers user1 user2

DenyGroups group1
DenyUsers user3 user4
```

```
sudo service ssh restart
```

## UFW Firewall [^3] [^4]

### UFW Status
```
sudo ufw status
```

```
sudo ufw enable
sudo ufw disable
```

```
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### Allow an IP Address

```
sudo ufw allow from xxx.xxx.xxx.xxx
```

### Block an IP Address

```
sudo ufw deny from xxx.xxx.xxx.xxx
```

### Block a Subnet

```
sudo ufw deny from xxx.xxx.xxx.0/24
```

### List Available Applications

```
sudo ufw app list
```

### Enable/Disable Applications

```
sudo ufw allow ssh
sudo ufw deny ssh
```

### Enable/Disable Ports

```
sudo ufw allow 22
sudo ufw deny 22
```

### Enable/Disable Specific Port Ranges

```
sudo ufw allow 6000:6007/tcp
sudo ufw allow 6000:6007/udp
sudo ufw deny 6000:6007/tcp
sudo ufw deny 6000:6007/udp
```

### Logs [^5]

```
sudo ufw logging on
sudo ufw logging off
```

```
sudo nano /var/log/uwf.log
```

## Fail2ban [^6] [^7]

```
sudo apt install fail2ban
```

```
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

```
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
findtime = 30m
bantime = 1d
ignoreip = 127.0.0.1/8 ::1 xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx
```

```
sudo systemctl start fail2ban
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban
sudo systemctl status fail2ban
```

```
sudo fail2ban-client set sshd banip xxx.xxx.xxx.xxx
sudo fail2ban-client set sshd unbanip xxx.xxx.xxx.xxx
```

```
sudo fail2ban-client status sshd
sudo nano /var/log/fail2ban.log
```

## Avoid Using FTP, Telnet, And Rlogin / Rsh Services on Linux

```
sudo apt-get --purge remove xinetd nis yp-tools tftpd atftpd tftpd-hpa telnetd rsh-server rsh-redone-server
```

## Linux Kernel /etc/sysctl.conf Hardening [^11]

```
sudo nano /etc/sysctl.conf
```

```
# Turn on execshield
kernel.exec-shield=1
kernel.randomize_va_space=1

# Enable IP spoofing protection
net.ipv4.conf.all.rp_filter=1

# Disable IP source routing
net.ipv4.conf.all.accept_source_route=0

# Ignoring broadcasts request (not pingable)
#net.ipv4.icmp_echo_ignore_broadcasts=1
#net.ipv4.icmp_ignore_bogus_error_messages=1

# Make sure spoofed packets get logged
net.ipv4.conf.all.log_martians = 1
```

[^1]: https://kb.iu.edu/d/aews
[^2]: https://linux-audit.com/using-ssh-keys-instead-of-passwords/
[^3]: https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
[^4]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
[^5]: https://fedingo.com/how-to-check-ufw-log-status/
[^6]: https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/
[^7]: https://www.linuxcapable.com/de/how-to-install-fail2ban-on-ubuntu-20-04-with-configuration/
[^8]: https://linux-audit.com/audit-and-harden-your-ssh-configuration/
[^9]: https://www.linuxbabe.com/linux-server/fix-ssh-locale-environment-variable-error
[^10]: https://www.kim.uni-konstanz.de/e-mail-und-internet/it-sicherheit/sicherer-server-it-dienst/linux-fernadministration-mit-pam-und-ssh/starke-authentifizierungsmethoden/
[^11]: https://www.cyberciti.biz/tips/linux-security.html
[^12]: https://www.informaticar.net/security-hardening-ubuntu-20-04/