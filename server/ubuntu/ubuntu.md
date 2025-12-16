# Ubuntu Server

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
```

## Installation

![Screenshot-1](./assets/linux_install_1.png)
![Screenshot-2](./assets/linux_install_2.png)
![Screenshot-3](./assets/linux_install_3.png)
![Screenshot-4](./assets/linux_install_4.png)
![Screenshot-5](./assets/linux_install_5.png)
![Screenshot-6](./assets/linux_install_6.png)
![Screenshot-7](./assets/linux_install_7.png)
![Screenshot-8](./assets/linux_install_8.png)
![Screenshot-9](./assets/linux_install_9.png)
![Screenshot-10](./assets/linux_install_10.png)
![Screenshot-11](./assets/linux_install_11.png)
![Screenshot-12](./assets/linux_install_12.png)
![Screenshot-13](./assets/linux_install_13.png)
![Screenshot-14](./assets/linux_install_14.png)
![Screenshot-15](./assets/linux_install_15.png)
![Screenshot-16](./assets/linux_install_16.png)
![Screenshot-17](./assets/linux_install_17.png)

### Updates

```bash
sudo apt update
sudo apt upgrade
```

### Cleanup

```bash
sudo apt clean
sudo apt autoclean
sudo apt autoremove
```

### Cleanup via CronJob [^5]

```bash
sudo nano ucleaner.sh
```

```
echo "\n\nSYSTEM CLEANUP\n\n"
echo "-------------------------------------------------------\n\n"

if [ $USER != root ]; then
  echo "\nError: must be root"
  echo "\nExiting..."
  exit 0
fi

echo "\n\nBefore command execution:-"
free -h

echo "\n\nClearing caches..."
sync; echo 1 > /proc/sys/vm/drop_caches

echo "\n\nRemoving old kernels..."
echo "Current kernel:-"
a=`uname -r|cut -f "2" -d "-"`
a=$(($a-2))
apt remove --purge linux-image-3.16.0-$a-generic

echo "\n\nClearing swap space..."
swapoff -a && swapon -a

echo "\n\nClearing application dependencies..."
apt clean
apt autoclean
apt autoremove

echo "\n\nEmptying every trashes..."
rm -rf /home/*/.local/share/Trash/*/**
rm -rf /root/.local/share/Trash/*/**

echo "\n\nAfter command execution:-"
free -h
```

```bash
sudo crontab -e
```

```
# Every Monday on 05:00 AM
0 5 * * 1	/home/ucleaner.sh
```

### Set Time Zone

```bash
sudo timedatectl set-timezone Europe/Berlin
sudo timedatectl
```

### Set Time Synchronization

```bash
sudo timedatectl set-ntp on
```

```bash
sudo nano /etc/systemd/timesyncd.conf
```

```
[Time]
NTP=time.uni-potsdam.de
FallbackNTP=times.tubit.tu-berlin.de
```

```bash
sudo systemctl restart systemd-timesyncd
sudo systemctl status systemd-timesyncd
```

### Set Hostname

```bash
sudo hostnamectl set-hostname [SERVER]
sudo nano /etc/cloud/cloud.cfg
```

```
FROM: preserve_hostname: false
TO: preserve_hostname: true
```

```bash
sudo nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 [SERVER]
[IPADDRESS] name.subdomain.sldomain.tldomain
```

```bash
sudo hostnamectl
```

### Set IP-Address

#### Netplan (new) [^1]

```bash
sudo nano /etc/netplan/00-installer-config.yaml
```

##### Fixed IP

```
network:
    version: 2
    renderer: networkd
    ethernets:
        en01:
            addresses:
            - [IPADDRESS]/24
            - "2001:1::1/64"
            gateway4: [IPADDRESS]
            gateway6: "2001:1::2"
            nameservers:
                addresses:
                - 8.8.8.8
                - xxx.xxx.xxx.xxx
```

```bash
sudo netplan apply
```

##### DHCP

```
network:
    version: 2
    renderer: networkd
    ethernets:
        en01:
            dhcp4: true
            dhcp6: true
```

```bash
sudo netplan apply
```

#### Network Interfaces (old) [^2]

```bash
sudo nano /etc/network/interfaces
```

##### Fixed IP

```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto en01
iface en01 inet static
    address [IPADDRESS]
    netmask 255.255.255.0
    network xxx.xxx.xxx.0
    broadcast xxx.xxx.xxx.255
    gateway xxx.xxx.xxx.xxx
    dns-nameservers xxx.xxx.xxx.xxx
    dns-search subdomain.domain.toplevel
```

```bash
sudo service networking restart
```

##### DHCP

```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
```

```bash
sudo service networking restart
```

### Change Password

```bash
sudo passwd [USER]
```

### Message of the Day [^3] [^4]

```bash
sudo nano /etc/motd
```

```

.-----------------------------------------------------------------------------.
||Es| |F1 |F2 |F3 |F4 |F5 | |F6 |F7 |F8 |F9 |F10|                  C= AMIGA   |
||__| |___|___|___|___|___| |___|___|___|___|___|                             |
| _____________________________________________     ________    ___________   |
||~  |! |" |§ |$ |% |& |/ |( |) |= |? |` || |<-|   |Del|Help|  |{ |} |/ |* |  |
||`__|1_|2_|3_|4_|5_|6_|7_|8_|9_|0_|ß_|´_|\_|__|   |___|____|  |[ |]_|__|__|  |
||<-  |Q |W |E |R |T |Z |U |I |O |P |Ü |* |   ||               |7 |8 |9 |- |  |
||->__|__|__|__|__|__|__|__|__|__|__|__|+_|_  ||               |__|__|__|__|  |
||Ctr|oC|A |S |D |F |G |H |J |K |L |Ö |Ä |^ |<'|               |4 |5 |6 |+ |  |
||___|_L|__|__|__|__|__|__|__|__|__|__|__|#_|__|       __      |__|__|__|__|  |
||^    |> |Y |X |C |V |B |N |M |; |: |_ |^     |      |A |     |1 |2 |3 |E |  |
||_____|<_|__|__|__|__|__|__|__|,_|._|-_|______|    __||_|__   |__|__|__|n |  |
|   |Alt|A  |                       |A  |Alt|      |<-|| |->|  |0    |. |t |  |
|   |___|___|_______________________|___|___|      |__|V_|__|  |_____|__|e_|  |
|                                                                             |
`-----------------------------------------------------------------------------'

```

### Message of the Day with FASTFETH or NEOFETCH

```bash
sudo apt install fastfetch
sudo nano /etc/profile.d/motd.sh
```

```
printf "\n"
fastfetch
```

```bash
sudo chmod +x /etc/profile.d/motd.sh
```

#### Configuration

```bash
sudo nano /usr/share/fastfetch/presets/myconfig.jsonc
sudo chmod 644 /usr/share/fastfetch/presets/myconfig.jsonc
sudo fastfetch --config myconfig.jsonc
```

### Security [^20]

#### Automatic Updates

```bash
sudo apt install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

```
Unattended-Upgrade::Allowed-Origins
{
    "${distro_id}:${distro_codename}-security";
    "${distro_id}ESMApps:${distro_codename}-apps-security";
    "${distro_id}ESM:${distro_codename}-infra-security";
};

Unattended-Upgrade::Package-Blacklist {

};

Unattended-Upgrade::DevRelease "false";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "02:00";

// Unattended-Upgrade::Mail "me@example.com ";
```

```bash
sudo nano /etc/apt/apt.conf.d/20auto-upgrades
```

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```

```bash
sudo unattended-upgrades --dry-run --debug
```

#### SSH

##### Login via Keys [^6] [^7]

###### Server

```bash
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

###### Client (Windows)

```bash
cd \Users\user
ssh-keygen -t rsa
type .ssh\id_rsa.pub | ssh user@[IPADDRESS] "cat >> .ssh/authorized_keys"
```

###### Client (Mac/Linux)

```bash
ssh-keygen -t rsa
ssh-copy-id -i .ssh/id_rsa.pub user@[IPADDRESS]
ssh -i .ssh/id_rsa user@[IPADDRESS]
```

##### Configuration [^13] [^14] [^15] [^23]

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
sudo sshd -T
sudo nano /etc/ssh/sshd_config
```

```
Protocol 2
Port 54321
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

```bash
sudo service ssh restart
```

#### Avoid Using FTP, Telnet, And Rlogin / Rsh Services on Linux

```bash
sudo apt --purge remove xinetd nis yp-tools tftpd atftpd tftpd-hpa telnetd rsh-server rsh-redone-server
```

#### Linux Kernel /etc/sysctl.conf Hardening [^16]

```bash
sudo nano /etc/sysctl.conf
```

```
# Restricts loading TTY line disciplines to the CAP_SYS_MODULE capability to prevent unprivileged attackers from loading vulnerable line disciplines with the TIOCSETD ioctl, which has been abused in a number of exploits before.
dev.tty.ldisc_autoload = 0

# Increase size of file handles and inode cache
fs.file-max = 2097152

# avoid unintentional writes to an attacker-controlled FIFO, where a program expected to create a regular file.
fs.protected_fifos = 2

# prevent users from creating hardlinks if they do not already own the source file, or do not have read/write access to it.
fs.protected_hardlinks = 1

# prevent writes to an attacker-controlled regular file
fs.protected_regular = 2

# prevent following symlinks to files inside sticky world-writable directories, except when the uid of the symlink and follower match, or when the directory owner matches the symlink's owner.
fs.protected_symlinks = 1

# Prevent core dumps from SUID processes. These are usually only needed by developers and may contain sensitive information.
fs.suid_dumpable = 0

# Controls whether core dumps will append the PID to the core filename. Useful for debugging multi-threaded applications
kernel.core_uses_pid = 1

# When an attacker is trying to exploit the local kernel, it is often helpful to be able to examine where in memory the kernel, modules, and data structures live. As such, kernel addresses should be treated as sensitive information.
# Many files and interfaces contain these addresses (e.g. /proc/kallsyms, /proc/modules, etc), and this setting can censor the addresses. A value of "0" allows all users to see the kernel addresses. A value of "1" limits visibility to the root user, and "2" blocks even the root user.
kernel.kptr_restrict = 2

# Number of seconds the kernel waits before rebooting on a panic. When you use the software watchdog, the recommended setting is 60. Setting this to 0 disables automatic reboot on panic.
kernel.panic = 60

# Allow for more PIDs 
kernel.pid_max = 65536

# Sets the time before the kernel considers migrating a proccess to another core
kernel.sched_migration_cost_ns = 5000000

# Disable the magic-sysrq key
kernel.sysrq = 0

# disable potentially exploitable unprivileged BPF
kernel.unprivileged_bpf_disabled = 1

# disable potentially exploitable unprivileged user namespaces
kernel.unprivileged_userns_clone = 0

# The PTRACE system is used for debugging. With it, a single user process can attach to any other dumpable process owned by the same user. In the case of malicious software, it is possible to use PTRACE to access credentials that exist in memory (re-using existing SSH connections, extracting GPG agent information, etc).
# 0: all processes can be debugged, as long as they have same uid.
# 1: only a parent process can be debugged.
# 2: only administrators with the CAP_SYS_PTRACE capability can use ptrace
# 3: no processes may be traced with ptrace. Once set, a reboot is needed to enable ptracing again.
kernel.yama.ptrace_scope = 2

# This enables hardening for the BPF JIT compiler. Supported are eBPF JIT backends. Enabling hardening trades off performance, but can mitigate JIT spraying. Values :
# 0 - disable JIT hardening (default value)
# 1 - enable JIT hardening for unprivileged users only
# 2 - enable JIT hardening for all users
net.core.bpf_jit_harden = 2

# Increase number of incoming connections backlog
net.core.netdev_max_backlog = 65536

# Increase the maximum amount of option memory buffers
net.core.optmem_max = 25165824

# Default Socket Receive Buffer
net.core.rmem_default = 33554432

# Maximum Socket Receive Buffer
net.core.rmem_max = 67108864

# Increase number of incoming connections
net.core.somaxconn = 65535

# Default Socket Send Buffer
net.core.wmem_default = 33554432

# Maximum Socket Send Buffer
net.core.wmem_max = 67108864

# Accept Redirects? No, this is not router
net.ipv4.conf.all.accept_redirects = 0

# Accept packets with SRR option? No
net.ipv4.conf.all.accept_source_route = 0

# Define restrictions for announcing the local source IP address from IP packets in ARP requests sent on interface
# 0 - (default) Use any local address, configured on any interface
# 1 - Try to avoid local addresses that are not in the target's subnet for this interface.
# 2 - Always use the best local address for this target.
net.ipv4.conf.all.arp_announce = 2
net.ipv4.conf.default.arp_announce = 2

# Define mode for sending replies in response to received ARP requests
# 0 - (default): reply for any local target IP address, configured on any interface
# 1 - reply only if the target IP address is local address configured on the incoming interface
# 2 - reply only if the target IP address is local address configured on the incoming interface AND is part of the sender's IP subnet
# 3 - do not reply for local addresses configured with scope host, only resolutions for global and link addresses are replied
# 4-7 - reserved
# 8 - never reply
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.default.arp_ignore = 1

# Don't relay BOOTP
net.ipv4.conf.all.bootp_relay = 0
net.ipv4.conf.default.bootp_relay = 0

# Enable/disable packet forwarding between interfaces (routing) globally
net.ipv4.conf.all.forwarding = 0
net.ipv4.conf.default.forwarding = 0

# log martian packets
# This feature logs packets with un-routable source addresses to the kernel log. This allows an administrator to investigate the possibility that an attacker is sending spoofed packets to their system.
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# Enable/disable forwarding of multicast packets
net.ipv4.conf.all.mc_forwarding = 0
net.ipv4.conf.default.mc_forwarding = 0

# Don't proxy ARP for anyone
net.ipv4.conf.all.proxy_arp = 0
net.ipv4.conf.default.proxy_arp = 0

# Enable IP spoofing protection, turn on source route verification. If the return packet does not go out the same interface that the corresponding source packet came from, the packet is dropped (and logged if log_martians is set).
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Accepting redirects can lead to malicious networking behavior, so disable it if not needed. Attackers could use bogus ICMP redirect messages to maliciously alter the system routing tables and get them to send packets to incorrect networks and allow your system packets to be captured.
# Setting net.ipv4.conf.all.secure_redirects to 0 protects the system from routing table updates by possibly compromised known gateways
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.accept_source_route = 0

# Accept/Ignore any ICMP ECHO requests (ping)
net.ipv4.icmp_echo_ignore_all = 1

# Ignore all ICMP ECHO and TIMESTAMP requests received via broadcast/multicast
net.ipv4.icmp_echo_ignore_broadcasts = 1

# There is no reason to accept bogus error responses from ICMP, so ignore them instead.
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Limit the amount of traffic the system uses for ICMP.
net.ipv4.icmp_ratelimit = 100

# Adjust the ICMP ratelimit to include ping, dst unreachable, source quench, ime exceed, param problem, timestamp reply, information reply
net.ipv4.icmp_ratemask = 88089

# Controls IP packet forwarding
net.ipv4.ip_forward = 0

# Increase system IP port limits
net.ipv4.ip_local_port_range = 2000 65535

# Decrease the time default value for tcp_fin_timeout connection
net.ipv4.tcp_fin_timeout = 15

# Decrease the time default value for connections to keep alive
net.ipv4.tcp_keepalive_intvl = 15
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_time = 300

# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks
net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1

# Protect Against TCP Time-Wait
net.ipv4.tcp_rfc1337 = 1

# Increase the read-buffer space allocatable
net.ipv4.tcp_rmem = 4096 65536 67108864
net.ipv4.udp_rmem_min = 16384

# Turn off TCP SACK
# Selective ACK computes/sends more precises ACKs and may be used for high-delay links
# SACK allows an attacker to force the machine to keep/process long/complex retransmission queues (possible DoS)
net.ipv4.tcp_sack = 0

# Enable TCP SYN Cookies (SYN flood Protection)
# Attackers use SYN flood attacks to perform a denial of service attack on a system by sending many SYN packets without completing the three way handshake.
# This will quickly use up slots in the kernel's half-open connection queue and prevent legitimate connections from succeeding.
# SYN cookies allow the system to keep accepting valid connections, even if under a denial of service attack. CIS Distro Independent 3.2.8.
net.ipv4.tcp_syn_retries = 5
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syncookies = 1

# Turn off TCP timestamps
net.ipv4.tcp_timestamps = 0

# Increase the write-buffer-space allocatable
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.udp_wmem_min = 16384

# Increase the maximum total buffer-space allocatable
net.ipv4.tcp_mem = 8388608 16777216 33554432
net.ipv4.udp_mem = 8388608 16777216 33554432

# Ignore Router Advertisements on IPv6
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0

# Ignore Default Router Preference in Router Advertisements
net.ipv6.conf.all.accept_ra_defrtr = 0
net.ipv6.conf.default.accept_ra_defrtr = 0

# Ignore Prefix Information in Router Advertisement
net.ipv6.conf.all.accept_ra_pinfo = 0
net.ipv6.conf.default.accept_ra_pinfo = 0

# Ignore Router Preference in Router Advertisements
net.ipv6.conf.all.accept_ra_rtr_pref = 0
net.ipv6.conf.default.accept_ra_rtr_pref = 0

# Accepting redirects can lead to malicious networking behavior, so disable it if not needed. Attackers could use bogus ICMP redirect messages to maliciously alter the system routing tables and get them to send packets to incorrect networks and allow your system packets to be captured.
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

# Disable IP Source Routing
# Drop packets with Strict Source Route (SSR) or Loose Source Routing (LSR) option set
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0

# Do not autoconfigure addresses using Prefix Information in Router Advertisements
net.ipv6.conf.all.autoconf = 0
net.ipv6.conf.default.autoconf = 0

# The amount of Duplicate Address Detection probes to send
net.ipv6.conf.all.dad_transmits = 0
net.ipv6.conf.default.dad_transmits = 0

# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

# Disable IPv6 traffic forwarding.
net.ipv6.conf.all.forwarding = 0
net.ipv6.conf.default.forwarding = 0

# Maximum number of autoconfigured addresses per interface
net.ipv6.conf.all.max_addresses = 1
net.ipv6.conf.default.max_addresses = 1

# Ignore Router Solicitations on IPv6
net.ipv6.conf.all.router_solicitations = 0
net.ipv6.conf.default.router_solicitations = 0

# Do less swapping
vm.dirty_background_ratio = 2
vm.dirty_ratio = 60
vm.swappiness = 10
```

```bash
sudo sysctl -p
```

#### ACL

```bash
sudo nano /etc/hosts.allow
```

```
sshd : localhost : allow
sshd : xxx.xxx.xxx.0/24 : allow
sshd : ALL : deny
```

```bash
sudo nano /etc/hosts.deny
```

```
sshd : xxx.xxx.xxx.0/24 : deny
```

[^1]: https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-configure-networking-in-ubuntu-20-04-with-netplan/
[^2]: https://www.cyberciti.biz/faq/setting-up-an-network-interfaces-file/
[^3]: https://nebulab.com/blog/awesome-motds-with-ubuntu
[^4]: https://www.asciiart.eu/
[^5]: https://github.com/jenil777007/ucleaner
[^6]: https://kb.iu.edu/d/aews
[^7]: https://linux-audit.com/using-ssh-keys-instead-of-passwords/
[^10]: https://fedingo.com/how-to-check-ufw-log-status/
[^13]: https://linux-audit.com/audit-and-harden-your-ssh-configuration/
[^14]: https://www.linuxbabe.com/linux-server/fix-ssh-locale-environment-variable-error
[^15]: https://www.kim.uni-konstanz.de/e-mail-und-internet/it-sicherheit/sicherer-server-it-dienst/linux-fernadministration-mit-pam-und-ssh/starke-authentifizierungsmethoden/
[^16]: https://www.cyberciti.biz/tips/linux-security.html
[^17]: https://www.informaticar.net/security-hardening-ubuntu-20-04/
[^23]: https://ittavern.com/ssh-server-hardening/
