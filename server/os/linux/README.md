# Linux (Ubuntu)

## Installation [1]

Insert the Ubuntu install CD / DVD / USB stick into your system and boot from it. When you install the OS in a virtual machine like I will do it here, then you should be able to select the downloaded ISO file as a source for the CD/DVD drive in VMWare and Virtualbox without burning it on CD first. Start the server or virtual machine, it will boot the system and start the installer.

![Step 01](./assets/ubuntu_install_01.png)

The first screen of the Ubuntu installer will show the language selector. Please select your language for the installation process:

![Step 02](./assets/ubuntu_install_02.png)

On the next screen, you can choose the keyboard layout. The English keyboard will be fine for many users. In this case, choose "Done" at the end of the screen and press the "Return" key, to go to the next step. In my case, I'm using a German keyboard layout, this means I'll have to navigate to the "Layout" option by pressing the "Tab" key on my keyboard until the Layout option is highlighted. Then press the "Return" key to open the Layout selector. 

![Step 03](./assets/ubuntu_install_03.png)

Choose the keyboard layout that matches the keyboard attached to the server.

![Step 04](./assets/ubuntu_install_04.png)

The right keyboard layout for my installation is selected now. Choose "Done" at the end of the screen and press "Return" to go to the next step.

![Step 05](./assets/ubuntu_install_05.png)

In the next step, the installer allows you to choose between a standard Ubuntu server setup or a minimal setup. I will select a minimal setup here and install only software that I need at a later stage. This is especially useful when running Ubuntu on a small virtual server.

![Step 06](./assets/ubuntu_install_06.png)

The Ubuntu installer now shows which network card it has detected on the server. The network device name that was assigned automatically is ens33. The IPv4 address has been assigned automatically via DHCP. I will change it later to a fixed IP address when the base system has been installed. If your network has no DHCP server, you can enter a fixed IP address now by choosing the network card (press Tab until it is highlighted and then press Return).

![Step 07](./assets/ubuntu_install_07.png)

Now you can set a proxy server address in case a proxy is required to access the internet. In my case, there is no proxy required, so I choose "Done" to go to the next installation step.

![Step 08](./assets/ubuntu_install_08.png)

Here, you can choose from which Ubuntu mirror server updates and installation files shall be downloaded. I'll keep the default and go to the next install screen.

![Step 09](./assets/ubuntu_install_09.png)

The Ubuntu server installer now shows the hard disk detected in the server. The installation disk is a 40GB HD on /dev/sda. I'll choose to use the entire disk for my Ubuntu installation. If you need a custom layout with multiple partitions, select "Custom Layout" instead and create partitions as required.

![Step 10](./assets/ubuntu_install_10.png)

The installer shows the default storage configuration below. It consists of a 2GB /boot partition plus one large / partition containing the operating system installation. But as we can see, Ubuntu left 19GB unused in the LVM partition. In the following steps, I will reconfigure the LVM partition to use all space for the / partition. Alternatively, you can use the unused space e.g. for a /home or /var partition, depending on how you plan to use the system.

![Step 11](./assets/ubuntu_install_11.png)

Go to the / partition (ubuntu-lv) in section 'used devices' as shown below.

![Step 12](./assets/ubuntu_install_12.png)

Choose to edit partition.

![Step 13](./assets/ubuntu_install_13.png)

Enter the max size into the size field.

![Step 14](./assets/ubuntu_install_14.png)

Press save, and now we have 100% of the space allocated to the / partition, as shown in the screenshot below.

![Step 15](./assets/ubuntu_install_15.png)

Before the installation starts, the Ubuntu installer requests to confirm the partitioning. Press the "Tab" key until the "Continue" option is highlighted in red, then press "Return" to proceed.

![Step 16](./assets/ubuntu_install_16.png)

Now it's time to set the server name (hostname) and the administrator's username and password. I'll choose the username 'administrator' here as an example. Please use a different and more secure name in your actual setup. The Ubuntu shell user we create in this step has sudo permissions, meaning he can administrate the system and become a root user via sudo.

![Step 17](./assets/ubuntu_install_17.png)

Ubuntu now offers the option to buy Ubuntu pro. I will use the OpenSource version here and skip that step.

![Step 18](./assets/ubuntu_install_18.png)

Most Linux servers get administered over the network using SSH. In this step, the Ubuntu installer can install the SSH server directly. Select the checkbox "Install OpenSSH Server" and proceed to the next step.

![Step 19](./assets/ubuntu_install_19.png)

In this step, you can preinstall commonly used services via Snap installer. I do not select any services here as the purpose of this guide is to install a minimal base system. You can install services via apt or snap at any time later.

![Step 20](./assets/ubuntu_install_20.png)

The Ubuntu installer now proceeds with the installation based on our chosen settings.

![Step 21](./assets/ubuntu_install_21.png)

Ubuntu Installation finished successfully. Select "Reboot" to boot the server into the fresh installed Ubuntu 24.04 system.

![Step 22](./assets/ubuntu_install_22.png)

Now login on the shell (or remotely by SSH) on the server as user "administrator". The username may differ if you have chosen a different name during setup.

![Step 23](./assets/ubuntu_install_23.png)

## Configuration

### Set Hostname

```bash
# Backup current /etc/hosts file with timestamp
sudo cp /etc/hosts /etc/hosts.$(date +%Y%m%d_%H%M%S).backup

# Set system hostname
sudo hostnamectl set-hostname MY_HOSTNAME

# Prevent cloud-init from overwriting hostname
sudo sed -i 's|preserve_hostname: false|preserve_hostname: true|g' /etc/cloud/cloud.cfg

# Manually edit /etc/hosts
sudo nano /etc/hosts
```

```
127.0.0.1   localhost
127.0.1.1   MY_HOSTNAME
IP          MY_HOSTNAME    MY_FQDN
```

### Set Time-Server

```bash
# Backup time sync configuration
sudo cp /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.$(date +%Y%m%d_%H%M%S).backup

# Edit time synchronization settings
sudo nano /etc/systemd/timesyncd.conf
```

```
[Time]
NTP=ptbtime1.ptb.de
FallbackNTP=0.de.pool.ntp.org 1.de.pool.ntp.org 2.de.pool.ntp.org 3.de.pool.ntp.org
```

```bash
# Set system timezone
sudo timedatectl set-timezone Europe/Berlin

# Enable NTP time synchronization
sudo timedatectl set-ntp on

# Restart time sync service
sudo systemctl restart systemd-timesyncd

# Show current time/date settings
sudo timedatectl
```

### Set SSH

```bash
# Install OpenSSH server
sudo apt install -y openssh-server

# Backup SSH daemon config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.$(date +%Y%m%d_%H%M%S).backup

# Edit SSH server configuration
sudo nano /etc/ssh/sshd_config
```

```
Include /etc/ssh/sshd_config.d/*.conf

# General
AcceptEnv LANG LC_*
Protocol 2
Port MY_SSHPORT
PrintMotd yes
Subsystem sftp internal-sftp

# Authentication
PermitRootLogin no
MaxAuthTries 3
LoginGraceTime 30
PermitEmptyPasswords no
PubkeyAuthentication yes
PasswordAuthentication yes
KbdInteractiveAuthentication no
UsePAM yes

# Session Security
ClientAliveInterval 300
ClientAliveCountMax 2
MaxSessions 4
MaxStartups 10:30:60

# Disable legacy methods
HostbasedAuthentication no
IgnoreRhosts yes

# Disable unnecessary features
X11Forwarding no
AllowTcpForwarding no
AllowAgentForwarding no
PermitTunnel no

# Strong crypto only (OpenSSH 9.x)
KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com

# Logging
LogLevel VERBOSE
```

```bash
# Enable SSH service at boot
sudo systemctl enable ssh
```

## Security

### Remove Bad Services

```bash
# Remove insecure/obsolete network services
sudo apt remove --purge -y xinetd nis yp-tools tftpd atftpd tftpd-hpa telnetd rsh-server rsh-redone-server
```

### Unattended Upgrades

```bash
# Install automatic security updates
sudo apt install -y unattended-upgrades

# Configure unattended upgrades interactively
sudo dpkg-reconfigure -plow unattended-upgrades

# Backup unattended-upgrades config
sudo cp /etc/apt/apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades.$(date +%Y%m%d_%H%M%S).backup

# Edit unattended-upgrades settings
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

```
Unattended-Upgrade::Allowed-Origins
{
    "\${distro_id}:\${distro_codename}";
    "\${distro_id}:\${distro_codename}-security";
    "\${distro_id}ESMApps:\${distro_codename}-apps-security";
    "\${distro_id}ESM:\${distro_codename}-infra-security";
};
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-New-Unused-Dependencies "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "02:38";
Unattended-Upgrade::Mail "MY_EMAIL";
```

```bash
# Backup auto-upgrades config
sudo cp /etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades.$(date +%Y%m%d_%H%M%S).backup

# Edit auto-upgrades schedule/config
sudo nano /etc/apt/apt.conf.d/20auto-upgrades
```

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
```

```bash
# Test unattended upgrades (no changes applied)
sudo unattended-upgrades --dry-run --debug
```

### Kernel Hardening

```bash
# Backup kernel/sysctl configuration
sudo cp /etc/sysctl.conf /etc/sysctl.conf.$(date +%Y%m%d_%H%M%S).backup

# Edit sysctl parameters
sudo nano /etc/sysctl.conf
```

```
############################
# KERNEL HARDENING
############################

kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
kernel.unprivileged_bpf_disabled = 1
kernel.unprivileged_userns_clone = 0
kernel.yama.ptrace_scope = 2
kernel.sysrq = 0
kernel.randomize_va_space = 2
fs.suid_dumpable = 0

############################
# FILESYSTEM PROTECTION
############################

fs.protected_fifos = 2
fs.protected_hardlinks = 1
fs.protected_regular = 2
fs.protected_symlinks = 1

############################
# NETWORK STACK HARDENING
############################

net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_sack = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.ip_forward = 0

############################
# IPv6 (leave enabled, but hardened)
############################

net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0

############################
# VM MEMORY TUNING
############################

vm.swappiness = 10
vm.dirty_background_ratio = 5
vm.dirty_ratio = 20
```

```bash
# Backup IRQ balancing config
sudo cp /etc/default/irqbalance /etc/default/irqbalance.$(date +%Y%m%d_%H%M%S).backup

# Edit IRQ balancing settings
sudo nano /etc/default/irqbalance
```

```
ENABLED="0"
```

```bash
# Backup system limits configuration
sudo cp /etc/security/limits.conf /etc/security/limits.conf.$(date +%Y%m%d_%H%M%S).backup

# Edit user/system resource limits
sudo nano /etc/security/limits.conf
```

```
#<domain>      <type>  <item>         <value>
#user1          hard    nproc           100
#@group1        hard    nproc           20
```

```bash
# Backup host resolution config
sudo cp /etc/host.conf /etc/host.conf.$(date +%Y%m%d_%H%M%S).backup

# Edit host resolution behavior
sudo nano /etc/host.conf
```

```
order bind,hosts
nospoof on
```

```bash
# Apply sysctl changes immediately
sudo sysctl -p /etc/sysctl.conf

# Restart IRQ balancing service (ignore errors if not present)
sudo systemctl restart irqbalance 2>/dev/null || true
```

### Install ufw

```bash
# Install UFW firewall
sudo apt install -y ufw

# Create log file (note: likely typo, should be ufw.log)
sudo touch /var/log/uwf.log

# Deny all incoming connections by default
sudo ufw default deny incoming

# Allow all outgoing connections
sudo ufw default allow outgoing

# Enable firewall logging
sudo ufw logging on

# Enable UFW without prompt
sudo ufw --force enable

# Show firewall status and rules
sudo ufw status verbose
```

```bash
# Allow NTP traffic
sudo ufw allow ntp

# Allow SSH access
sudo ufw allow ssh
```

### Install fail2ban

```bash
# Install Fail2Ban for intrusion prevention
sudo apt install -y fail2ban

# Backup Fail2Ban config
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.$(date +%Y%m%d_%H%M%S).backup

# Edit Fail2Ban configuration
sudo nano /etc/fail2ban/jail.conf
```

```
[DEFAULT]
backend = systemd
bantime = 1h
banaction = ufw
findtime = 10m
ignoreip = 127.0.0.1/8
maxretry = 3

# Alerts
destemail = MY_EMAIL
sender = MY_NAME
action = %(action_mwl)s

[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
maxretry = 3
bantime = 1d
```

```bash
# Enable Fail2Ban to start at boot and start it immediately
sudo systemctl enable fail2ban --now

# Restart Fail2Ban service to apply configuration changes
sudo systemctl restart fail2ban

# Show UFW firewall rules with line numbers (useful for rule management)
sudo ufw status numbered

# Display current status and logs of Fail2Ban service
sudo systemctl status fail2ban
```

## Password Asterix

```bash
sudo visudo
```

```
# Locate the line that reads Defaults env_reset and modify it to include pwfeedback
Defaults env_reset,pwfeedback
```

## CleanUp

```bash
# Clean package cache
sudo apt clean -y

# Remove obsolete package files
sudo apt autoclean -y

# Remove unused packages
sudo apt autoremove -y
```

[1]: https://www.howtoforge.com/tutorial/ubuntu-24-04-minimal-server/