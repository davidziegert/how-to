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

install_harica_1() {
    local country=""
    local state=""
    local city=""
    local organization=""

# Create certificate signing request
cat << EOF > /etc/ssl/$fqdn.csr.conf
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no
utf8 = yes
[req_distinguished_name]
C = $country
ST = $state
L = $city
O = $organization
CN = $fqdn
[v3_req]
subjectAltName = @alt_names
[alt_names]
DNS.1 = $fqdn
EOF

    openssl genrsa -out /etc/ssl/$fqdn.key 4096
    openssl req -new -out /etc/ssl/$fqdn.csr -key /etc/ssl/$fqdn.key -config /etc/ssl/$fqdn.csr.conf

    printf "\e[1;32m"
    printf "✅  SSL-Request prepared \n"
}

install_harica_2() {
    # Enable SSL module (for HTTPS)
    a2enmod ssl
    a2enmod rewrite
    a2enmod headers

    # Copy Certificates
    echo "Place your certificate at /etc/ssl/$fqdn.fullchain.pem"
    # nano /etc/ssl/$fqdn.fullchain.pem

    #Permissions
    chmod 640 /etc/ssl/$fqdn.csr.conf
    chmod 644 /etc/ssl/$fqdn.csr
    chmod 600 /etc/ssl/$fqdn.key
    chmod 644 /etc/ssl/$fqdn.fullchain.pem

# Create certificate signing request
cat << EOF > /etc/apache2/sites-available/000-default.conf
# Global scope
SSLStaplingCache shmcb:/var/run/apache2/stapling_cache(128000)

<VirtualHost *:80>
    ServerAdmin $email
    ServerName $host
    ServerAlias $fqdn

    DocumentRoot /var/www/html/

    <Directory /var/www/html/>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    # Redirect all HTTP traffic to HTTPS
    RewriteEngine on
    RewriteCond %{SERVER_NAME} =$fqdn
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>

<IfModule mod_ssl.c>
    <VirtualHost *:443>
        ServerAdmin $email
        ServerName $host
        ServerAlias $fqdn

        DocumentRoot /var/www/html/

        <Directory /var/www/html/>
            Options -Indexes +FollowSymLinks +MultiViews
            AllowOverride All
            Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # SSL Configuration
        SSLEngine on
        SSLCertificateFile /etc/ssl/$fqdn.fullchain.pem
        SSLCertificateKeyFile /etc/ssl/$fqdn.key

        SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
        SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        SSLOpenSSLConfCmd Ciphersuites "TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
        SSLHonorCipherOrder off
        SSLSessionTickets off
        SSLCompression off
        SSLUseStapling on

        # Security Headers
        <IfModule mod_headers.c>
            Header always set X-Content-Type-Options "nosniff"
            Header always set X-Frame-Options "SAMEORIGIN"
            Header always set X-XSS-Protection "1; mode=block"
            Header always set Referrer-Policy "strict-origin-when-cross-origin"
            Header always set Content-Security-Policy "default-src 'self';"
            Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
        </IfModule>
    </VirtualHost>
</IfModule>
EOF

    # Services
    apache2ctl configtest
    systemctl restart apache2

    printf "\e[1;32m"
    printf "✅  SSL-Certificate configured \n"
}

# ─── Menu ─────────────────────────────────────────────────────────────────
if_invalid() {
    printf "\e[1;33m"
    printf "⚠️  Invalid response, try again: "
}

print_menu() {
    # App list
    local APPS=(
        "HARICA Part 1"
        "HARICA Part 2"
    )

    # App installer functions
    local INSTALL_CMDS=(
        "install_harica_1"
        "install_harica_2"
    )

    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "         🚀  HARICA SSL v1.0  🚀         \n"
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
