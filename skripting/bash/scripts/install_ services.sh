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
install_motd() {
    local TO_INSTALL=( "figlet" )

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
    local conf_file_1="/etc/update-motd.d/99-custom"

    backup_file "$conf_file_1"

# /etc/update-motd.d/99-custom — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
printf "You're connected to: \n"
figlet "$(hostname -s)"
EOF

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
}

install_nfs_server() {
    local TO_INSTALL=( "nfs-kernel-server" )

    # Config
    local mode="home"           # or share
    local export_dir="/home"    # or /share
    local export_net="192.168.1.0/24"
    local export_options="rw,sync,no_subtree_check,root_squash"
    local export_line="$export_dir $export_net($export_options)"
    local domain="localdomain"  # or ldap domain

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

    # Modes
    if [ "$mode" = "home" ]; then
        # Ensure base permissions (do NOT override user dirs)
        chmod 755 /home

        printf "\e[1;32m"
        printf "✅  Mode: %s \n" "${mode}"
    elif [ "$mode" = "share" ]; then
        local export_grp="sharegroup"

        # Create export directory
        mkdir -p "$export_dir"

        # Set ownership and permissions
        chown nobody:"$export_grp" "$export_dir"
        chmod 770 "$export_dir"

        printf "\e[1;32m"
        printf "✅  Mode: %s \n" "${mode}"
    else
        printf "\e[1;31m"
        printf "❌  Unkown mode: %s \n" "${mode}"
        return 1
    fi

    # Backup
    local conf_file_1="/etc/exports"
    local conf_file_2="/etc/idmapd.conf"

    backup_file "$conf_file_1"
    backup_file "$conf_file_2"

    # Set /etc/exports
    if ! grep -qs "^$export_dir " "$conf_file_1"; then
        printf "%s" >> "$conf_file_1" "${export_line}" 
    fi

    # Set /etc/idmapd.conf
    if grep -q "domain" "$conf_file_2"; then
        sed -i "s/^domain.*/domain = $domain/" "$conf_file_2"
    else
        printf "[General] \n" >> "$conf_file_2"
        printf "domain = %s" >> "$conf_file_2" "${domain}" 
    fi

    # Apply exports
    exportfs -ra

    # Apply in firewall
    ufw allow from "$export_net" to any port nfs

    # Services
    systemctl enable nfs-kernel-server
    systemctl restart nfs-kernel-server
    systemctl status nfs-kernel-server

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
}

install_nfs_client() {
    local TO_INSTALL=( "nfs-common" )

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

    # Config
    local mode="home" # or share
    local nfs_server="192.168.1.10"
    local remote_dir="/home" # or /share
    local mnt_dir="/home" # or /share
    local mnt_options="rw,sync,no_subtree_check,root_squash" # for /home
    # local mnt_options="rw,sync,hard,intr,_netdev,nofail,noatime,vers=4" # for /share
    local fstab_line="$nfs_server:$remote_dir $mnt_dir nfs $mnt_options 0 0"
    local domain="localdomain"  # or ldap domain

    # Backup only if original doesn't already exist
    local conf_file_1="/etc/fstab"
    local conf_file_2="/etc/idmapd.conf"
    local conf_file_3="/etc/pam.d/common-session"
    local conf_file_4="/etc/profile"
    local conf_file_5="/etc/login.defs"

    backup_file "$conf_file_1"
    backup_file "$conf_file_2"
    backup_file "$conf_file_3"
    backup_file "$conf_file_4"
    backup_file "$conf_file_5" 

    local umask="0007"
    local defs_umask=""

    # Modes
    if [ "$mode" = "home" ]; then
        # IMPORTANT: do NOT overwrite /home contents accidentally
        if mount | grep -q "on /home "; then
            printf "\e[1;33m"
            printf "⚠️  /home already mounted \n"
            return 1
        else
            # ensure /home exitst
            mkdir -p "$mnt_dir"
        fi

        printf "\e[1;32m"
        printf "✅  Mode: %s \n" "${mode}"
    elif [ "$mode" = "share" ]; then
        # create /share dir
        mkdir -p "$mnt_dir"

        printf "\e[1;32m"
        printf "✅  Mode: %s \n" "${mode}"
    else
        printf "\e[1;31m"
        printf "❌  Unkown mode: %s \n" "${mode}"
        return 1
    fi

     # Set /etc/fstab
    if ! grep -qs "^$nfs_server:$remote_dir $mnt_dir " "$conf_file_1"; then
        printf "%s" >> "$conf_file_1" "${fstab_line}" 
    else
        printf "\e[1;33m"
        printf "⚠️  Folder already mounted \n"
    fi

    # Set /etc/idmapd.conf
    if grep -q "domain" "$conf_file_2"; then
        sed -i "s/^domain.*/domain = $domain/" "$conf_file_2"
    else
        printf "[General] \n" >> "$conf_file_2"
        printf "domain = %s" >> "$conf_file_2" "${domain}" 
    fi

    if [ "$mode" = "home" ]; then
        # Set /etc/pam.d/common-session
        if ! grep -q "pam_mkhomedir.so" "$conf_file_3"; then
            printf "\n# Ensures /home/xy are created securely \n" >> "$conf_file_3"
            printf "session required pam_mkhomedir.so skel=/etc/skel umask=%s" >> "$conf_file_3" "${umask}"
        fi

        # Set /etc/profile
        if ! grep -q "umask $umask" "$conf_file_4"; then           
            printf "\n# Ensures files created in shell stay private \n" >> "$conf_file_4"
            printf "umask=%s" >> "$conf_file_4" "${umask}"
        fi

        # Set /etc/login.defs
        defs_umask=$(grep -E '^[[:space:]]*UMASK' "$conf_file_5" | awk '{print $2}')
        
        if [ "$defs_umask" != "$umask" ]; then
            sed -i "s/^[[:space:]]*UMASK.*/UMASK $umask/" "$conf_file_5" || \
            printf "/n# Makes system-wide default safe /n" >> "$conf_file_5"
            printf "umask=%s" >> "$conf_file_5" "${umask}"
        fi
    fi

    # Services
    systemctl enable nfs-common
    systemctl restart nfs-common
    systemctl status nfs-common

    # Apply in firewall
    ufw allow from "$nfs_server" to any port nfs

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    df -h
    printf "**************************************** \n"
}

install_ldap_server() {
    local TO_INSTALL=( "slapd" "ldap-utils" "openssl" )

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

    # Config
    local ldap_domain="example.com"
    local ldap_org="ORAGNIZATION"
    local ldap_password="NEW_PASSWORD"
    local cert_dir="/etc/ssl/ldap"
    local cert_file="$cert_dir/ldap.crt"
    local key_file="$cert_dir/ldap.key"
    local cert_c="COUNTRY"
    local cert_st="COUNTY"
    local cert_l="CITY"

    # Convert domain to DC format (example.com -> dc=example,dc=com)
    local ldap_base_dn="dc=${ldap_domain//./,dc=}"

# Preseed debconf answers
debconf-set-selections <<EOF
slapd slapd/no_configuration boolean false
slapd slapd/domain string $ldap_domain
slapd shared/organization string $ldap_org
slapd slapd/password1 password $ldap_password
slapd slapd/password2 password $ldap_password
slapd slapd/backend select MDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true
slapd slapd/allow_ldap_v2 boolean false
EOF

    # Re-Config
    dpkg-reconfigure -f noninteractive slapd

    # Services
    systemctl enable slapd
    systemctl restart slapd
    systemctl status slapd

    # Setup Certificate
    mkdir -p $cert_dir
    chmod 700 $cert_dir

    # Generate self-signed cert
    openssl req -x509 -nodes -days 3650 \
    -newkey rsa:4096 \
    -keyout $key_file \
    -out $cert_file \
    -subj "/C=$cert_c/ST=$cert_st/L=$cert_l/O=$ldap_org/CN=$ldap_domain"

    # Permissions
    chown root:root $key_file $cert_file
    chmod 600 $key_file
    chmod 644 $cert_file

# Create LDIF for TLS config
cat <<EOF > /tmp/tls.ldif
dn: cn=config
changetype: modify
add: olcTLSCertificateFile
olcTLSCertificateFile: $cert_file
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: $key_file
EOF

    # Apply TLS config via ldapi (local socket, root EXTERNAL auth)
    ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/tls.ldif

    # Enable LDAPS in default config
    sed -i 's/^SLAPD_SERVICES=.*/SLAPD_SERVICES="ldap:\/\/\/ ldapi:\/\/\/ ldaps:\/\/\/"/' /etc/default/slapd

    # Services
    systemctl restart slapd
    systemctl status slapd

    # Allow in firewall
    # Set ufw
    # ufw allow ldap
    ufw allow ldaps

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "LDAPS Connection: \n"

    ldapsearch -x -H ldaps://localhost \
    -b "$ldap_base_dn" \
    -D "cn=admin, $ldap_base_dn" \
    -w "$ldap_password"
    printf "**************************************** \n"
}

install_ldap_client() {
    local TO_INSTALL=( "sssd" "libnss-sss" "libpam-sss" "ldap-utils" )

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

    # Config
    local ldap_uri="ldaps://ldap.example.com"
    local ldap_base_dn="dc=example,dc=com"
    local ldap_bind_dn="cn=admin,dc=example,dc=com"
    local ldap_bind_password="NEW_PASSWORD"
    local ldap_tls_ca_cert="/etc/ssl/ldap/ldap.crt"

    # Backup
    local conf_file_1="/etc/nsswitch.conf"
    local conf_file_2="/etc/sssd/sssd.conf"

    backup_file "$conf_file_1"
    backup_file "$conf_file_2"

    # Configuring NSS config
    sed -i 's/^passwd:.*/passwd:    files systemd sss/' $conf_file_1
    sed -i 's/^group:.*/group:      files systemd sss/' $conf_file_1
    sed -i 's/^shadow:.*/shadow:    files sss/' $conf_file_1

    pam-auth-update --enable mkhomedir || true

# /etc/sssd/sssd.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_2
[sssd]
services = nss, pam
config_file_version = 2
domains = default

[domain/default]
id_provider = ldap
auth_provider = ldap
chpass_provider = ldap

ldap_uri = $ldap_uri
ldap_search_base = $ldap_base_dn

ldap_default_bind_dn = $ldap_bind_dn
ldap_default_authtok = $ldap_bind_password

cache_credentials = True
enumerate = False

# TLS
ldap_tls_ca_cert = $ldap_tls_ca_cert
ldap_tls_reqcert = demand

# Optional:
ldap_id_use_start_tls = False
EOF

    chmod 600 $conf_file_2

    # Services
    systemctl enable sssd
    systemctl restart sssd

    # Copy LDAPS cert
    scp root@ldap.example.com:$ldap_tls_ca_cert $ldap_tls_ca_cert
    
    # Permissions
    chown root:root $ldap_tls_ca_cert
    chmod 644 $ldap_tls_ca_cert
    
    update-ca-certificates

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "✅  LDAP User-Lookup: \n"
    getent passwd
    printf "**************************************** \n"
}

install_samba() {
    local TO_INSTALL=( "samba" "sssd" "libnss-sss" "libpam-sss" "ldap-utils" )

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

    # Config
    ldap_uri="ldaps://ldap.example.com"
    ldap_base_dn="dc=example,dc=com"
    ldap_bind_dn="cn=admin,dc=example,dc=com"
    ldap_bind_password="NEW_PASSWORD"
    ldap_tls_ca_cert="/etc/ssl/ldap/ldap.crt"

    samba_workgroup="WORKGROUP"
    samba_home_path="/home"
    samba_share_path="/share"

    # Configuring NSS config
    sed -i 's/^passwd:.*/passwd:    files systemd sss/' $conf_file_1
    sed -i 's/^group:.*/group:      files systemd sss/' $conf_file_1
    sed -i 's/^shadow:.*/shadow:    files sss/' $conf_file_1

    pam-auth-update --enable mkhomedir || true

    # Backup
    local conf_file_1="/etc/nsswitch.conf"
    local conf_file_2="/etc/sssd/sssd.conf"
    local conf_file_3="/etc/samba/smb.conf"

    backup_file "$conf_file_1"
    backup_file "$conf_file_2"
    backup_file "$conf_file_3"

# /etc/sssd/sssd.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_2
[sssd]
services = nss, pam
config_file_version = 2
domains = default

[domain/default]
id_provider = ldap
auth_provider = ldap
chpass_provider = ldap

ldap_uri = $ldap_uri
ldap_search_base = $ldap_base_dn

ldap_default_bind_dn = $ldap_bind_dn
ldap_default_authtok = $ldap_bind_password

cache_credentials = True
enumerate = False

ldap_tls_ca_cert = $ldap_tls_ca_cert
ldap_tls_reqcert = demand
EOF

# /etc/samba/smb.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_3
[global]
   workgroup = $samba_workgroup
   security = user
   passdb backend = ldapsam
   obey pam restrictions = yes
   pam password change = yes
   unix password sync = yes
   map to guest = bad user

[homes]
   path = $samba_home_path
   comment = Home Directories
   browsable = no
   read only = no
   create mask = 0700
   directory mask = 0700
   # Restrict access
   valid users = %S @users

[shared]
   path = $samba_share_path
   comment = Shared Directories
   browsable = yes
   read only = no
   guest ok = no
   create mask = 0660
   directory mask = 0770
   # Restrict access
   valid users = @users
EOF

    # Permissions
    chmod 600 $conf_file_2

    mkdir -p $samba_share_path
    chown root:users $samba_share_path
    chmod 2770 $samba_share_path


    # Services
    systemctl enable smbd nmbd sssd
    systemctl restart smbd nmbd sssd

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "LDAP User-Lookup: \n"
    printf "**************************************** \n"
    getent passwd
    printf "**************************************** \n"
    getent group
    printf "**************************************** \n"
}

install_bind9() {
    local TO_INSTALL=( "bind9" "bind9utils" "bind9-doc" "dnsutils" )

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

    # Config
    local domain_zone="example.local"
    local domain_zone_file="/etc/bind/db.$domain_zone"
    local reverse_zone="1.168.192.in-addr.arpa"
    local reverse_zone_file="/etc/bind/db.$reverse_zone"
    local dns_clients="192.168.1.0/24;"
    local serial; serial=$(date +%Y%m%d01)

    # Backup
    local conf_file_1="/etc/bind/named.conf.options"
    local conf_file_2="/etc/bind/named.conf.local"
    backup_file "$conf_file_1"
    backup_file "$conf_file_2"

# /etc/bind/named.conf.options — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_1
options {
    directory "/var/cache/bind";

    // Hide version (security hardening)
    version "not currently available";

    // Enable recursion (needed for internal clients)
    recursion yes;

    // Restrict recursion to trusted networks only
    allow-recursion {
        127.0.0.1;
        10.10.10.0/24;
        $dns_clients
    };

    // Allow queries from anywhere (authoritative zones)
    allow-query { any; };

    // Forward DNS queries to upstream resolvers
    forwarders {
        1.1.1.1;
        8.8.8.8;
    };

    // Enable DNSSEC validation
    dnssec-validation auto;

    // Listen on IPv4 and optionally IPv6
    listen-on { any; };
    listen-on-v6 { any; };

    // Prevent abuse
    allow-transfer { none; };

    // Logging
    querylog yes;

    // Additional hardening
    auth-nxdomain no;        # RFC compliance
    minimal-responses yes;
};
EOF

# /etc/bind/named.conf.local — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_2
zone "$domain_zone" {
    type master;
    file "$domain_zone_file";
    allow-query { any; };
};

zone "$reverse_zone" {
    type master;
    file "$reverse_zone_file";
    allow-query { any; };
};
EOF

# /etc/bind/db.$domain_zone — no leading spaces, EOF at column 0
cat <<EOF > $domain_zone_file
$TTL    86400
@       IN      SOA     dns.$domain_zone.    admin.$domain_zone.  (
                        $serial         ; Serial
                        7200            ; Refresh
                        3600            ; Retry
                        604800          ; Expire
                        86400 )         ; Negative Cache TTL

                        IN      NS      dns.$domain.
dns.$domain_zone.       IN      A       $ip

client_1                IN      A       192.168.1.1
EOF

# /etc/bind/db.$reverse_zone — no leading spaces, EOF at column 0
cat <<EOF > $reverse_zone_file
$TTL    86400
@       IN      SOA     dns.$domain_zone.    admin.$domain_zone.  (
                        $serial         ; Serial
                        7200            ; Refresh
                        3600            ; Retry
                        604800          ; Expire
                        86400 )         ; Negative Cache TTL

                        IN      NS      dns.$domain.
dns.$domain_zone.       IN      A       $ip

1                       IN      PTR     client_1.$domain_zone.
EOF

    # Allow in firewall
    ufw allow Bind9

    # Services
    named-checkconf
    named-checkzone $domain_zone $domain_zone_file
    named-checkzone $reverse_zone $reverse_zone_file

    systemctl enable named
    systemctl restart named
    systemctl status named

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
}

install_unbound() {
    local TO_INSTALL=( "unbound" )

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

    # Download Root Hints
    wget -O /var/lib/unbound/root.hints https://www.internic.net/domain/named.cache
    chown unbound:unbound /var/lib/unbound/root.hints

    # Config
    local domain_zone="example.local"
    local dns_clients="192.168.1.0/24;"

    # Backup
    local conf_file_1="/etc/unbound/unbound.conf.d/resolver.conf"
    local conf_file_2="/etc/unbound/unbound.conf.d/local-zones.conf"
    backup_file "$conf_file_1"
    backup_file "$conf_file_2"

# /etc/unbound/unbound.conf.d/resolver.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_1
server:
    # Interfaces (restrict to localhost unless you need LAN access)
    interface: 127.0.0.1
    interface: ::1
    port: 53

    # Allow local network access
    access-control: 127.0.0.0/8 allow
    access-control: 10.0.0.0/8 allow
    access-control: $dns_clients allow

    # Privacy hardening
    hide-identity: yes
    hide-version: yes
    qname-minimisation: yes
    minimal-responses: yes

    # DNSSEC
    auto-trust-anchor-file: "/var/lib/unbound/root.key"
    harden-dnssec-stripped: yes
    harden-algo-downgrade: yes

    # Additional hardening
    harden-glue: yes
    harden-referral-path: yes
    use-caps-for-id: yes

    # Cache tuning
    cache-min-ttl: 300
    cache-max-ttl: 86400
    prefetch: yes
    prefetch-key: yes

    # Performance
    num-threads: 2
    so-reuseport: yes
    msg-cache-size: 128m
    rrset-cache-size: 256m

    # Security limits
    unwanted-reply-threshold: 10000000
    do-not-query-localhost: no

    # Logging (disable in high-performance setups)
    verbosity: 1
    logfile: ""

    # Root hints
    root-hints: "/var/lib/unbound/root.hints"
EOF

# /etc/unbound/unbound.conf.d/local-zones.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_2
local-zone: "$domain_zone." static
    local-data: "client_1.$domain_zone.     IN      A       192.168.1.1"
EOF

    # Services
    unbound-checkconf
    systemctl is-enabled unbound
    systemctl status unbound
    systemctl restart unbound
    systemctl status unbound

    # Allow in firewall
    ufw allow 53

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
}

install_dhcp() {
    local TO_INSTALL=( "isc-dhcp-server" )

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

    # Config
    local interface="" 
    interface=$(ip route get 8.8.8.8 | awk '{print $5}')
    local domain_name="example.local"
    local subnet="192.168.1.0"
    local netmask="255.255.255.0"
    local gateway="192.168.1.254"
    local range_start="192.168.1.100"
    local range_end="192.168.1.200"
    local dns="192.168.1.1"

    local conf_file_1="/etc/dhcp/dhcpd.conf"
    backup_file "$conf_file_1"

    # Configuring interface
    sudo sed -i "s/^INTERFACESv4=.*/INTERFACESv4=\"$interface\"/" /etc/default/isc-dhcp-server

# /etc/dhcp/dhcpd.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_1
# Global options
option domain-name "$domain_name";
option domain-name-servers $dns;
option routers $gateway;
option subnet-mask $netmask;

# Default lease time (seconds)
default-lease-time 600;
max-lease-time 7200;

# DHCP server is authoritative for this network
authoritative;

# Log messages
log-facility local7;

subnet $subnet netmask $netmask {
    range $range_start $range_end;

    host client_001 {hardware ethernet 00:00:39:3E:E3:E2; fixed-address 192.168.1.100;}
}
EOF

    # Allow in firewall
    ufw allow 67

    # Services
    systemctl enable isc-dhcp-server.service
    systemctl restart isc-dhcp-server.service
    systemctl status isc-dhcp-server --no-pager

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "**************************************** \n"
    dhcp-lease-list
    printf "**************************************** \n"
}

install_kea() {
    local TO_INSTALL=( "kea-dhcp4-server" )

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

    # Config
    local interface="" 
    interface=$(ip route get 8.8.8.8 | awk '{print $5}')
    local domain_name="example.local"
    local subnet="192.168.1.0"
    local netmask="255.255.255.0"
    local gateway="192.168.1.254"
    local range_start="192.168.1.100"
    local range_end="192.168.1.200"
    local dns="192.168.1.1"

    local conf_file_1="/etc/kea/kea-dhcp4.conf"
    backup_file "$conf_file_1"

# /etc/kea/kea-dhcp4.conf — no leading spaces, EOF at column 0
cat <<EOF > $conf_file_1
{
    "Dhcp4": {
        "interfaces-config": {
            "interfaces": [ "$interface" ]
        },

        "lease-database": {
            "type": "memfile",
            "persist": true,
            "name": "/var/lib/kea/kea-leases4.csv"
        },

        "valid-lifetime": 86400,
        "renew-timer": 43200,
        "rebind-timer": 75600,

        "subnet4": [
            {
                "subnet": "$subnet/$netmask",
                "pools": [
                    {
                        "pool": "$range_start - $range_end"
                    }
                ],
                "option-data": [
                    {
                        "name": "routers",
                        "data": "$gateway"
                    },
                    {
                        "name": "domain-name-servers",
                        "data": "$dns"
                    }
                ],
                "reservations": [
                    {
                        "hw-address": "00:00:39:3E:E3:E2",
                        "ip-address": "192.168.1.100"
                    }
                ]
            }
        ]
    }
}
EOF

    # Allow DHCP traffic
    ufw allow 67

    # Services
    systemctl enable kea-dhcp4-server
    systemctl restart kea-dhcp4-server
    systemctl status kea-dhcp4-server --no-pager

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "**************************************** \n"
    dhcp-lease-list
    printf "**************************************** \n"
}

# ─── Menu ─────────────────────────────────────────────────────────────────
if_invalid() {
    printf "\e[1;33m"
    printf "⚠️  Invalid response, try again: "
}

print_menu() {
    # App list
    local APPS=(
        "MOTD"
        "NFS SERVER"
        "NFS CLIENT"
        "LDAP SERVER"
        "LDAP CLIENT"
        "SAMBA"
        "BIND9 DNS"
        "UNBOUND DNS"
        "ISC DHCP"
        "KEA DHCP"
    )

    # App installer functions
    local INSTALL_CMDS=(
        "install_motd"
        "install_nfs_server"
        "install_nfs_client"
        "install_ldap_server"
        "install_ldap_client"
        "install_samba"
        "install_bind9"
        "install_unbound"
        "install_dhcp"
        "install_kea"
    )

    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "     🚀  SERVICE INSTALLER v1.0  🚀      \n"
    printf "**************************************** \n"

    for i in "${!APPS[@]}"; do
        printf "%2d) %s \n" $((i+1)) "${APPS[$i]}"
    done

    # Read user selection
    read -rp " Your selection: " -a SELECTIONS
    printf "**************************************** \n"
    SELECTED_CMDS=()

    # Validate selections
    for choice in "${SELECTIONS[@]}"; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#APPS[@]} )); then
            index=$((choice-1))
            SELECTED_CMDS+=("${INSTALL_CMDS[$index]}")
        else
            printf "\e[1;33m"
            printf "⚠️  Invalid choice: %s \n" "$choice"
        fi
    done

    # Run installers
    for cmd in "${SELECTED_CMDS[@]}"; do
        eval "$cmd"
    done
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
