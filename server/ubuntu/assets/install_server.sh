#!/bin/sh


######## server-variables ########
echo "Please enter Hostname:" 
read _HOSTNAME

echo "Please enter Domainname:" 
read _DOMAINNAME

echo "Please enter Admin-Mail:" 
read _EMAIL

echo "Please enter SSH-Port:" 
read _PORT

_IP=$(hostname -I)
##################################


############ hostnames ###########
hostnamectl set-hostname $_HOSTNAME
sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg
> /etc/hosts
cat <<EOT >> /etc/hosts

127.0.0.1	localhost
127.0.1.1	$_HOSTNAME
$_IP	$_HOSTNAME	$_DOMAINNAME

EOT
echo "######## INSERT HOSTNAME - DONE! ########"
##################################


########## set timezones #########
timedatectl set-timezone Europe/Berlin
timedatectl
timedatectl set-ntp on
> /etc/systemd/timesyncd.conf
cat <<EOT >> /etc/systemd/timesyncd.conf

[Time]
NTP=time.uni-potsdam.de
FallbackNTP=times.tubit.tu-berlin.de

EOT
systemctl restart systemd-timesyncd
echo "######## SET NTP - DONE! ########"
##################################


######## kernel hardening ########
> /etc/sysctl.conf
cat <<EOT >> /etc/sysctl.conf

### NETWORKING

# Enable/disable packet forwarding between interfaces (routing) globally
net.ipv4.conf.all.forwarding = 0
net.ipv4.conf.default.forwarding = 0
# Enable/disable forwarding of multicast packets
net.ipv4.conf.all.mc_forwarding = 0
net.ipv4.conf.default.mc_forwarding = 0

# Accepting redirects can lead to malicious networking behavior, so disable
# it if not needed. Attackers could use bogus ICMP redirect messages to maliciously alter the system
# routing tables and get them to send packets to incorrect networks and allow your system packets to be captured.
# Setting net.ipv4.conf.all.secure_redirects to 0 protects the system from routing table updates
# by possibly compromised known gateways
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

# For non-routers: don't send redirects.
# An attacker could use a compromised host to send invalid ICMP redirects to other
# router devices in an attempt to corrupt routing and have users access a system
# set up by the attacker as opposed to a valid system.
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
# Disable IPv6 traffic forwarding.
net.ipv6.conf.all.forwarding = 0
net.ipv6.conf.default.forwarding = 0
# Limit configuration information disclosed by IPv6
# Ignore Router Advertisements on IPv6
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
# Ignore Router Solicitations on IPv6
net.ipv6.conf.all.router_solicitations = 0
net.ipv6.conf.default.router_solicitations = 0
# Ignore Router Preference in Router Advertisements
net.ipv6.conf.all.accept_ra_rtr_pref = 0
net.ipv6.conf.default.accept_ra_rtr_pref = 0
# Ignore Prefix Information in Router Advertisement
net.ipv6.conf.all.accept_ra_pinfo = 0
net.ipv6.conf.default.accept_ra_pinfo = 0
# Ignore Default Router Preference in Router Advertisements
net.ipv6.conf.all.accept_ra_defrtr = 0
net.ipv6.conf.default.accept_ra_defrtr = 0
# Do not autoconfigure addresses using Prefix Information in Router Advertisements
net.ipv6.conf.all.autoconf = 0
net.ipv6.conf.default.autoconf = 0
# The amount of Duplicate Address Detection probes to send
net.ipv6.conf.all.dad_transmits = 0
net.ipv6.conf.default.dad_transmits = 0
# Maximum number of autoconfigured addresses per interface
net.ipv6.conf.all.max_addresses = 1
net.ipv6.conf.default.max_addresses = 1

# Disable IP Source Routing
# Drop packets with Strict Source Route (SSR) or Loose Source Routing (LSR) option set
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0

# Enable IP spoofing protection, turn on source route verification
# If the return packet does not go out the same interface that the corresponding
# source packet came from, the packet is dropped (and logged if log_martians is set).
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Accept/Ignore any ICMP ECHO requests (ping)
net.ipv4.icmp_echo_ignore_all = 1

# Ignore all ICMP ECHO and TIMESTAMP requests received via broadcast/multicast
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Limit the amount of traffic the system uses for ICMP.
net.ipv4.icmp_ratelimit = 100

# Adjust the ICMP ratelimit to include ping, dst unreachable, source quench, ime exceed, param problem, timestamp reply, information reply
net.ipv4.icmp_ratemask = 88089

# There is no reason to accept bogus error responses from ICMP, so ignore them instead.
net.ipv4.icmp_ignore_bogus_error_responses = 1

# log martian packets
# This feature logs packets with un-routable source addresses to the kernel log.
# This allows an administrator to investigate the possibility that an attacker
# is sending spoofed packets to their system.
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# Decrease the time default value for tcp_fin_timeout connection
net.ipv4.tcp_fin_timeout = 15
# Decrease the time default value for tcp_keepalive_time connection
net.ipv4.tcp_keepalive_time = 1800

# The maximum number of "backlogged sockets".  Default is 128.
# Increasing the default value should only be needed on high-loaded servers where new connection rate is
# so high/bursty that having 128 not-yet-accepted connections is considered normal.
# net.core.somaxconn = 1024

# Disable TCP window scaling (disabled)
# net.ipv4.tcp_window_scaling = 0

# Turn off TCP SACK
# Selective ACK computes/sends more precises ACKs and may be used for high-delay links
# SACK allows an attacker to force the machine to keep/process long/complex retransmission queues (possible DoS)
net.ipv4.tcp_sack = 0

# Turn off TCP timestamps
# Disable TCP timestamps in order to not reveal system uptime.
net.ipv4.tcp_timestamps = 0

# Don't relay BOOTP
net.ipv4.conf.all.bootp_relay = 0
net.ipv4.conf.default.bootp_relay = 0

# Enable TCP SYN Cookies (SYN flood Protection)
# Attackers use SYN flood attacks to perform a denial of service attack on a system
# by sending many SYN packets without completing the three way handshake.
# This will quickly use up slots in the kernel's half-open connection queue and
# prevent legitimate connections from succeeding.
# SYN cookies allow the system to keep accepting valid connections, even if
# under a denial of service attack. CIS Distro Independent 3.2.8.
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 5

# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks
net.ipv4.tcp_max_tw_buckets = 1440000

# Maximal number of remembered connection requests, which have not received an
# acknowledgment from connecting client. The minimal value is 128 for low memory
# machines, and it will increase in proportion to the memory of machine. If server 
# suffers from overload, try increasing this number.
#net.ipv4.tcp_max_syn_backlog = 20480

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

# Define mode for notification of address and device changes.
# 0 - (default): do nothing
# 1 - Generate gratuitous arp requests when device is brought up or hardware address changes.
# net.ipv4.conf.all.arp_notify = 0

# Define behavior when receiving gratuitous ARP frames whose IP is not already present in the ARP table
# 0 - don't create new entries in the ARP table
# 1 - create new entries in the ARP table
# net.ipv4.conf.all.arp_accept = 0
# net.ipv4.conf.default.arp_accept = 0

# Don't proxy ARP for anyone
net.ipv4.conf.all.proxy_arp = 0
net.ipv4.conf.default.proxy_arp = 0

### MISC SECURITY

# Disable the magic-sysrq key
kernel.sysrq = 0

# Controls whether core dumps will append the PID to the core filename.
kernel.core_uses_pid = 1

# Prevent core dumps from SUID processes. These are usually only needed by developers and may contain sensitive information.
fs.suid_dumpable = 0

# When an attacker is trying to exploit the local kernel, it is often
# helpful to be able to examine where in memory the kernel, modules,
# and data structures live. As such, kernel addresses should be treated
# as sensitive information.
#
# Many files and interfaces contain these addresses (e.g. /proc/kallsyms,
# /proc/modules, etc), and this setting can censor the addresses. A value
# of "0" allows all users to see the kernel addresses. A value of "1"
# limits visibility to the root user, and "2" blocks even the root user.
kernel.kptr_restrict = 2

# The PTRACE system is used for debugging. With it, a single user process
# can attach to any other dumpable process owned by the same user. In the
# case of malicious software, it is possible to use PTRACE to access
# credentials that exist in memory (re-using existing SSH connections,
# extracting GPG agent information, etc).
# 0: all processes can be debugged, as long as they have same uid.
# 1: only a parent process can be debugged.
# 2: only administrators with the CAP_SYS_PTRACE capability can use ptrace
# 3: no processes may be traced with ptrace. Once set, a reboot is needed to enable ptracing again.
kernel.yama.ptrace_scope = 2

# disable potentially exploitable unprivileged user namespaces
kernel.unprivileged_userns_clone = 0

# disable potentially exploitable unprivileged BPF
kernel.unprivileged_bpf_disabled = 1

# Restricts loading TTY line disciplines to the CAP_SYS_MODULE capability to
# prevent unprivileged attackers from loading vulnerable line disciplines with
# the TIOCSETD ioctl, which has been abused in a number of exploits before.
dev.tty.ldisc_autoload = 0

# avoid unintentional writes to an attacker-controlled FIFO, where a program
# expected to create a regular file.
fs.protected_fifos = 2

# prevent users from creating hardlinks if they do not already own the source file,
# or do not have read/write access to it.
fs.protected_hardlinks = 1

# prevent writes to an attacker-controlled regular file
fs.protected_regular = 2

# prevent following symlinks to files inside sticky world-writable directories, except
# when the uid of the symlink and follower match, or when the directory owner matches
# the symlink's owner.
fs.protected_symlinks = 1

# This enables hardening for the BPF JIT compiler. Supported are eBPF JIT backends.
# Enabling hardening trades off performance, but can mitigate JIT spraying. Values :
# 0 - disable JIT hardening (default value)
# 1 - enable JIT hardening for unprivileged users only
# 2 - enable JIT hardening for all users
net.core.bpf_jit_harden = 2

# Number of seconds the kernel waits before rebooting on a panic.
# When you use the software watchdog, the recommended setting is 60.
# Setting this to 0 disables automatic reboot on panic.
kernel.panic = 60

EOT
echo "######## KERNEL HARDENING - DONE! ########"
##################################


#### avoid using bad services ####
apt --purge remove xinetd nis yp-tools tftpd atftpd tftpd-hpa telnetd rsh-server rsh-redone-server
echo "######## REMOVE BAD SERVICES - DONE! ########"
##################################


######## auto upgrades ########
apt install unattended-upgrades -y
dpkg-reconfigure -plow unattended-upgrades
> /etc/apt/apt.conf.d/50unattended-upgrades
cat <<EOT >> /etc/apt/apt.conf.d/50unattended-upgrades

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
Unattended-Upgrade::Mail "$_EMAIL";

EOT

> /etc/apt/apt.conf.d/20auto-upgrades
cat <<EOT >> /etc/apt/apt.conf.d/20auto-upgrades

APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";

EOT

unattended-upgrades --dry-run --debug
echo "######## AUTO UPGRADE - DONE! ########"
##############################


######### ssh config #########
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
> /etc/ssh/sshd_config
cat <<EOT >> /etc/ssh/sshd_config

Include /etc/ssh/sshd_config.d/*.conf

AcceptEnv LANG LC_*
ChallengeResponseAuthentication no
HostbasedAuthentication no
IgnoreRhosts yes
MaxAuthTries 3
PasswordAuthentication yes
PermitEmptyPasswords no
PermitRootLogin no
Port $_PORT
PrintMotd yes
Protocol 2
PubkeyAuthentication yes
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
X11Forwarding no

EOT

sshd -T
echo "######## SSH CONFIG - DONE! ########"
##############################


######## ufw firewall ########
ufw default deny incoming
ufw default allow outgoing
ufw allow ntp
ufw allow ssh
ufw allow $_PORT
> /var/log/uwf.log
ufw logging on
ufw enable

echo "######## ENABLE UFW - DONE! ########"
##############################


########## fail2ban ##########
apt install fail2ban -y
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
> /etc/fail2ban/jail.conf
cat <<EOT >> /etc/fail2ban/jail.conf

[INCLUDES]
before = paths-debian.conf

[DEFAULT]
backend = polling				# POLLING ALGORITHM (NO EXTERNAL LIBRARIES)
banaction = ufw					# JAIL VIA UFW
bantime  = 1h					# BANTIME
enabled = true					# ENABLE JAILS
findtime = 10m					# TIMESPAN BETWEEN FAILED ATTEMPTS
ignoreip = 127.0.0.1/8 ::1		# IGNORELIST
logencoding = auto				# USE SYSTEM LOCAL ENCODING (UTF-8)
maxretry = 3					# NUMBER OF FAILED ATTEMPTS

[sshd]
backend = polling
banaction = ufw
bantime  = 1d
enabled = true
filter = sshd
findtime = 1h
logpath = /var/log/auth.log
maxretry = 3
port = ssh

EOT

echo "######## ENABLE FAIL2BAN - DONE! ########"
##############################


##### message of the day #####
nano /etc/motd

echo "######## SET MOTD - DONE! ########"
##############################


##### updates and cleanup ####
apt update -y
apt upgrade -y
apt clean
apt autoclean
apt autoremove

echo "######## CLEANUP - DONE! ########"
##############################


########### reboot ###########
while true; do

read -p "Do you want to reboot now? (y/n): " yn

case $yn in 
	[yY] ) reboot --force
		break;;
	[nN] ) 
		exit;;
	* ) echo invalid response;;
esac

done
##############################