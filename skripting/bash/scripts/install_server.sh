#!/bin/bash

# ─── Exit on error, undefined vars, pipe failures ─────────────────────────
set -euo pipefail

# ─── Server-variables ────────────────────────────────────────────────────────
ip=$(hostname -I | awk '{print $1}')
host=$(hostname --short)
fqdn=$(hostname --fqdn)
email=""
sshport=""

# ─── Helper ───────────────────────────────────────────────────────────────
check_root(){
    if [[ $EUID -eq 0 ]]; then
        printf "\e[1;32m"
        printf "✅  You have root \n"
    else
        printf "\e[1;31m"
        printf "❌  You have no root \n"
        exit 1
    fi
}

check_server_variables() {   
        while true; do
            printf "\e[1;34m"
            printf "**************************************** \n"
            printf "        🚀  SERVER VARIABLES  🚀         \n"
            printf "**************************************** \n"
            printf "1) IP:\t\t %s \n" "$ip"
            printf "2) HOST:\t %s \n" "$host"
            printf "3) FQDN:\t %s \n" "$fqdn"
            printf "4) E-MAIL:\t %s \n" "$email"
            printf "5) SSH-PORT:\t %s \n" "$sshport"
            printf "6) Proceed \n"
            printf "7) Start Over \n"
            printf "**************************************** \n"
            
            read -rp " Your choice [1-7]: " choice

            case $choice in
                1) read -rp " ENTER IP:       " ip ;;
                2) read -rp " ENTER HOST:     " host ;;
                3) read -rp " ENTER FQDN:     " fqdn ;;
                4) read -rp " ENTER EMAIL:    " email ;;
                5) read -rp " ENTER SSHPORT:  " sshport ;;
                6) break ;;
                7) check_server_variables; return ;;
                *) if_invalid ;;
            esac
        done

        printf "**************************************** \n"
        printf "\e[1;32m"
        printf "✅  Got all server variables \n"
}

backup_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        printf "\e[1;31m"
        printf "❌  File: %s not found \n" "$file"
        return 1
    elif [ -f "$file.$(date +%Y%m%d_%H%M%S).backup" ]; then
        printf "\e[1;33m"
        printf "⚠️  Backup: %s already exists \n" "$file"
        return 1
    else
        cp "$file" "$file.$(date +%Y%m%d_%H%M%S).backup"
        printf "\e[1;32m"
        printf "✅  Backup: %s created \n" "$file.$(date +%Y%m%d_%H%M%S).backup"
    fi
}

# ─── Apps ─────────────────────────────────────────────────────────────────
remove_services() {
    local to_remove=( "xinetd" "nis" "yp-tools" "tftpd" "atftpd" "tftpd-hpa" "telnetd" "rsh-server" "rsh-redone-server" )

    # Try removing the package
    printf "\e[1;33m"
    printf "⏳  Try removing: %s \n" "${to_remove[@]}"

    if apt remove --purge -y -qq "${to_remove[@]}"; then
        printf "\e[1;32m"
        printf "✅  Removed successful: %s \n" "${to_remove[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Removing failed: %s \n" "${to_remove[@]}"
        return 1
    fi
}

set_hostname () {
    # Backup
	local conf_file_1="/etc/hosts"

	backup_file "$conf_file_1"

    # Set hostname
    hostnamectl set-hostname "$host"

    # Only modify cloud.cfg if it exists
    if [ -f /etc/cloud/cloud.cfg ]; then
        sed -i 's|preserve_hostname: false|preserve_hostname: true|g' /etc/cloud/cloud.cfg
    else
        echo "cloud.cfg not found, skipping."
        printf "\e[1;31m"
        printf "❌  File: cloud.cfg not found \n"
    fi

# Write /etc/hosts — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
127.0.0.1   localhost
127.0.1.1   $host
$ip         $host $fqdn
EOF

        printf "\e[1;32m"
        printf "✅  Configuration successful: hostnamectl \n"
}


install_unattended-upgrades() {
    local TO_INSTALL=( "unattended-upgrades" )
	local reboot_time="02:38"

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        dpkg-reconfigure -plow unattended-upgrades
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Backup
	local conf_file_1="/etc/apt/apt.conf.d/50unattended-upgrades"
	local conf_file_2="/etc/apt/apt.conf.d/20auto-upgrades"

	backup_file "$conf_file_1"
	backup_file "$conf_file_2"

# /etc/apt/apt.conf.d/50unattended-upgrades — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
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
Unattended-Upgrade::Automatic-Reboot-Time "$reboot_time";
Unattended-Upgrade::Mail "$email";
EOF

# /etc/apt/apt.conf.d/20auto-upgrades — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_2"
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
EOF

    # Verify config with dry-run
    if unattended-upgrades --dry-run --debug; then
        printf "\e[1;32m"
        printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Configuration failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi
}

install_ufw() {
    local TO_INSTALL=( "ufw" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        touch /var/log/uwf.log
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Set default policies
    ufw default deny incoming
    ufw default allow outgoing

    # Allow only custom SSH port (not generic 'ssh'/22)
    ufw allow "$sshport"/tcp comment 'Custom SSH port'

    # Enable logging (ufw manages its own log via rsyslog)
    ufw logging on

    # Enable firewall non-interactively
    ufw --force enable

    # Verify status
    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "**************************************** \n"
    ufw status verbose
    printf "**************************************** \n"
}

set_timeserver() {
    local timezone="Europe/Berlin"
    local ntp_primary="ptbtime1.ptb.de"
    local ntp_fallback="0.de.pool.ntp.org 1.de.pool.ntp.org 2.de.pool.ntp.org 3.de.pool.ntp.org"
    
    printf "\e[1;33m"
    printf "⏳  Setup: timedatectl \n"

    # Backup
    local conf_file_1="/etc/systemd/timesyncd.conf"
	
	backup_file "$conf_file_1"

# Write NTP config — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
[Time]
NTP=$ntp_primary
FallbackNTP=$ntp_fallback
EOF

    # Set timezone
    timedatectl set-timezone "$timezone"

    # Enable NTP
    timedatectl set-ntp on

    # Allow in firewall
    ufw allow ntp

    # Apply changes
    systemctl restart systemd-timesyncd

    # Verify sync status
    printf "\e[1;32m"
    printf "✅  Configuration successful: timedatectl \n"
    printf "**************************************** \n"
    timedatectl
    printf "**************************************** \n"
}

set_ssh() {
    local TO_INSTALL=( "openssh-server" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

	# Backup
	local conf_file_1="/etc/ssh/sshd_config"
	
	backup_file "$conf_file_1"

# /etc/ssh/sshd_config — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
Include /etc/ssh/sshd_config.d/*.conf

# General
AcceptEnv LANG LC_*
Protocol 2
Port $sshport
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
EOF

    # Services
    systemctl enable ssh

    # Allow in firewall
    ufw allow ssh

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
}

install_fail2ban() {
    local TO_INSTALL=( "fail2ban" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt install -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Backup
    local conf_file_1="/etc/fail2ban/jail.conf"
	
	backup_file "$conf_file_1"

# /etc/fail2ban/jail.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
[DEFAULT]
backend = systemd
bantime = 1h
banaction = ufw
findtime = 10m
ignoreip = 127.0.0.1/8
maxretry = 3

# Alerts
destemail = $email
sender = root@$host
action = %(action_mwl)s

[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
maxretry = 3
bantime = 1d
EOF

    # Services
    systemctl enable fail2ban --now
    systemctl restart fail2ban

    # Check in firewall
    ufw status numbered

    # Verify sync status
    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "**************************************** \n"
    systemctl status fail2ban
    printf "**************************************** \n"
}

do_hardening() {
    # Backup
	local conf_file_1="/etc/sysctl.conf"
	local conf_file_2="/etc/default/irqbalance"
	local conf_file_3="/etc/security/limits.conf"
	local conf_file_4="/etc/host.conf"

	backup_file "$conf_file_1"
	backup_file "$conf_file_2"
	backup_file "$conf_file_3"
	backup_file "$conf_file_4"

# /etc/sysctl.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
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
EOF

# /etc/default/irqbalance — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_2"
ENABLED="0"
EOF

# /etc/security/limits.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_3"
#<domain>      <type>  <item>         <value>
#user1          hard    nproc           100
#@group1        hard    nproc           20
EOF

# /etc/host.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_4"
order bind,hosts
nospoof on
EOF

    # Apply kernel settings immediately
    sysctl -p "$conf_file_1"

	# Apply irqbalance
	systemctl restart irqbalance 2>/dev/null || true

    printf "\e[1;32m"
    printf "✅  Hardening successful! \n"
}

# ─── Menu ─────────────────────────────────────────────────────────────────
print_menu() {
    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "      🚀  SERVER INSTALLER v1.0  🚀      \n"
    printf "**************************************** \n"

    apt -y -qq update
    apt -y -qq upgrade
    remove_services
    set_hostname
    install_unattended-upgrades
    install_ufw
    set_timeserver
    set_ssh
    install_fail2ban
    do_hardening
}

# ─── Main ─────────────────────────────────────────────────────────────────
start_main() {
    clear

    printf "\e[1;34m"
    printf "**************************************** \n"

    check_root
    check_server_variables
    print_menu

    printf "\e[1;34m"
    printf "**************************************** \n"
}

# ─── Initialize ───────────────────────────────────────────────────────────
start_main
