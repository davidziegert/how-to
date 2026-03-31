#!/bin/bash

# ─── Exit on error, undefined vars, pipe failures ─────────────────────────
set -euo pipefail

# ─── Server-variables ────────────────────────────────────────────────────────
host=$(hostname --short)
fqdn=$(hostname --fqdn)
email=""

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
        printf "1) HOST:\t %s \n" "$host"
        printf "2) FQDN:\t %s \n" "$fqdn"
        printf "3) E-MAIL:\t %s \n" "$email"
        printf "4) Proceed \n"
        printf "5) Start Over \n"
        printf "**************************************** \n"
        read -rp " Your choice [1-5]: " choice
        printf "**************************************** \n"
        case $choice in
            1) read -rp " ENTER HOST:     " host ;;
            2) read -rp " ENTER FQDN:     " fqdn ;;
            3) read -rp " ENTER EMAIL:    " email ;;
            4) break ;;
            5) check_server_variables; return ;;
            *) if_invalid ;;
        esac
    done

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
install_apache() {
    local TO_INSTALL=( "apache2" "wget" "unzip" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Backup
	local conf_file_1="/etc/apache2/apache2.conf"
    local conf_file_2="/etc/apache2/sites-available/default-ssl.conf"
    local conf_file_3="/etc/apache2/sites-available/000-default.conf"
    local conf_file_4="/etc/apache2/mods-available/deflate.conf"
    local conf_file_5="/etc/apache2/mods-available/expires.conf"
    local conf_file_6="/etc/apache2/mods-available/mpm_event.conf"

	backup_file "$conf_file_1"
	backup_file "$conf_file_2" && rm "$conf_file_2"
    backup_file "$conf_file_3"
    backup_file "$conf_file_4"
    backup_file "$conf_file_5"
    backup_file "$conf_file_6"

    # Configuration
# /etc/apache2/apache2.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
# The directory where shm and other runtime files will be stored.
DefaultRuntimeDir ${APACHE_RUN_DIR}

# PidFile: The file in which the server should record its process identification number when it starts.
PidFile ${APACHE_PID_FILE}

# Timeout: The number of seconds before receives and sends time out.
Timeout 300

# KeepAlive: Whether or not to allow persistent connections (more than one request per connection). Set to "Off" to deactivate.
KeepAlive On

# MaxKeepAliveRequests: The maximum number of requests to allow # during a persistent connection.
MaxKeepAliveRequests 100

# KeepAliveTimeout: Number of seconds to wait for the next request from the same client on the same connection.
KeepAliveTimeout 5

# Server name (prevents startup warnings)
ServerName localhost

# These need to be set in /etc/apache2/envvars
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}

# HostnameLookups: Log the names of clients or just their IP addresses
HostnameLookups Off

# ErrorLog: The location of the error log file.
ErrorLog ${APACHE_LOG_DIR}/error.log

# LogLevel: Control the severity of messages logged to the error_log.
LogLevel warn

# Include module configuration:
IncludeOptional mods-enabled/*.load
IncludeOptional mods-enabled/*.conf

# Include list of ports to listen on
Include ports.conf

# Sets the default security model of the Apache2 HTTPD server.
<Directory />
	Options FollowSymLinks
	AllowOverride None
	Require all denied
</Directory>

<Directory /usr/share>
	AllowOverride None
	Require all granted
</Directory>

<Directory /var/www/>
	Options Indexes FollowSymLinks
	AllowOverride None
	Require all granted
</Directory>

# AccessFileName: The name of the file to look for in each directory for additional configuration directives.
AccessFileName .htaccess

# The following lines prevent .htaccess and .htpasswd files from being # viewed by Web clients.
<FilesMatch "^\.ht">
	Require all denied
</FilesMatch>

# The following directives define some format nicknames for use with a CustomLog directive.
LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %O" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent

# Include generic snippets of statements
IncludeOptional conf-enabled/*.conf

# Include the virtual host configurations:
IncludeOptional sites-enabled/*.conf
EOF

# /etc/apache2/sites-available/000-default.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_3"
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
</VirtualHost>
EOF

# /etc/apache2/mods-available/deflate.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_4"
<IfModule mod_deflate.c>
	AddOutputFilterByType DEFLATE application/javascript
	AddOutputFilterByType DEFLATE application/json
	AddOutputFilterByType DEFLATE application/xml
	AddOutputFilterByType DEFLATE text/css
	AddOutputFilterByType DEFLATE text/html
	AddOutputFilterByType DEFLATE text/javascript
	AddOutputFilterByType DEFLATE text/plain
	AddOutputFilterByType DEFLATE text/xml
</IfModule>

<IfModule mod_filter.c>
	AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript
	AddOutputFilterByType DEFLATE application/x-javascript application/javascript application/ecmascript
	AddOutputFilterByType DEFLATE application/rss+xml
	AddOutputFilterByType DEFLATE application/wasm
	AddOutputFilterByType DEFLATE application/xml
</IfModule>
EOF

# /etc/apache2/mods-available/expires.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_5"
<IfModule mod_expires.c>
	ExpiresActive On

	# Default expiration
	ExpiresDefault "access plus 1 month"

	# HTML - no cache
	ExpiresByType text/html "access plus 0 seconds"

	# CSS and JavaScript
	ExpiresByType text/css "access plus 1 year"
	ExpiresByType application/javascript "access plus 1 year"

	# Images
	ExpiresByType image/jpeg "access plus 1 year"
	ExpiresByType image/png "access plus 1 year"
	ExpiresByType image/gif "access plus 1 year"
	ExpiresByType image/svg+xml "access plus 1 year"
</IfModule>
EOF

# /etc/apache2/mods-available/mpm_event.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_6"
# low-traffic sites
StartServers            2
MinSpareThreads         25
MaxSpareThreads         75
ThreadLimit             64
ThreadsPerChild         25
MaxRequestWorkers       150
MaxConnectionsPerChild  0

# high-traffic sites
#StartServers            4
#MinSpareThreads         75
#MaxSpareThreads         250
#ThreadLimit             64
#ThreadsPerChild         25
#MaxRequestWorkers       400
#MaxConnectionsPerChild  10000
EOF

    # Modules
    # Enable rewrite module (for clean URLs, .htaccess rules)
    a2enmod rewrite
    # Enable headers module (for security headers)
    a2enmod headers
    # Enable deflate module (for compression)
    a2enmod deflate
    # Enable expires module (for cache control)
    a2enmod expires
    # Enable proxy modules (for reverse proxy)
    a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests

    # Services
    apache2ctl configtest
    systemctl enable apache2
    systemctl restart apache2

    # Allow in firewall
    ufw allow "Apache Full"

    # Permissions
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} +
    find /var/www/html -type f -exec chmod 644 {} +

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "⚠️  Status: %s \n" "$(systemctl is-active apache2)"
}

install_certbot() {
    local TO_INSTALL=( "certbot" "python3-certbot-apache" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Modules
    a2enmod ssl
    a2enmod rewrite

    # Services
    systemctl restart apache2

    # Obtain SSL certificate
    certbot --apache -d "$fqdn" -m "$email" --agree-tos --non-interactive --redirect

    # Set automatic certificate renewal
    systemctl status certbot.timer
    systemctl enable certbot.timer
    systemctl start certbot.timer
    certbot renew --dry-run

    # Backup
    local conf_file_1="/etc/apache2/sites-available/000-default.conf"

	backup_file "$conf_file_1"

    # Configuration
# /etc/apache2/sites-available/000-default.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
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
        SSLCertificateFile /etc/letsencrypt/live/$fqdn/fullchain.pem
        SSLCertificateKeyFile /etc/letsencrypt/live/$fqdn/privkey.pem
        Include /etc/letsencrypt/options-ssl-apache.conf

        SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
        SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        SSLOpenSSLConfCmd Ciphersuites "TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
        SSLHonorCipherOrder off
        SSLSessionTickets off
        SSLCompression off

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
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
}

install_php() {
    local TO_INSTALL=( "php" "libapache2-mod-php" "php-{common,curl,dom,fpm,gd,imagick,intl,json,mbstring,mysql,opcache,xml,zip}" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Safe, Linux-compatible PHP version extraction
    php_version=$(php -v | head -n 1 | awk '{print $2}' | cut -d '.' -f 1,2)

    # Verify directory
    if [ -d "/etc/php/$php_version" ]; then
        printf "\e[1;33m"
        printf "⚠️ Directory found: %s \n" "/etc/php/$php_version"
    else
        printf "\e[1;31m"
        printf "❌ Directory not found: %s \n" "/etc/php/$php_version"
        return 1
    fi

    # Backup
    local conf_file_1="/etc/php/$php_version/fpm/php.ini"
    local conf_file_2="/etc/php/$php_version/fpm/pool.d/www.conf"

	backup_file "$conf_file_1"
	backup_file "$conf_file_2"

    # Configuration
# /etc/php/$php_version/fpm/php.ini — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= BASE SETTINGS ===================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[PHP]
engine = On
short_open_tag = Off
precision = 14
serialize_precision = -1
output_buffering = 4096
implicit_flush = Off
zend.enable_gc = On
zend.exception_ignore_args = On
zend.exception_string_param_max_len = 0
expose_php = Off
default_charset = "UTF-8"
default_mimetype = "text/html"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= ERROR HANDLING ==================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

error_reporting = E_ALL
display_errors = Off
display_startup_errors = Off
log_errors = On
error_log = /var/log/php_errors.log
html_errors = Off
ignore_repeated_errors = On
report_memleaks = Off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= RESOURCE LIMITS =================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

memory_limit = 256M
max_execution_time = 60
max_input_time = 60
max_input_vars = 3000
max_file_uploads = 20
post_max_size = 32M
upload_max_filesize = 32M
default_socket_timeout = 60

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= FILE & STREAM SETTINGS ==========
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

file_uploads = On
allow_url_fopen = Off
allow_url_include = Off
enable_dl = Off
cgi.fix_pathinfo = 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= DISABLED FUNCTIONS =============
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

disable_functions = exec,passthru,shell_exec,system,proc_open,popen,pcntl_exec,dl

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= VARIABLES =======================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= SESSION HARDENING ==============
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Session]
session.save_handler = files
session.use_strict_mode = 1
session.use_cookies = 1
session.use_only_cookies = 1
session.use_trans_sid = 0
session.name = PHPSESSID
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_httponly = 1
session.cookie_secure = 1
session.cookie_samesite = Strict
session.sid_length = 64
session.sid_bits_per_character = 6
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= OPCACHE =========================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[opcache]
opcache.enable = 1
opcache.enable_cli = 0
opcache.memory_consumption = 128
opcache.interned_strings_buffer = 16
opcache.max_accelerated_files = 20000
opcache.validate_timestamps = 0
opcache.revalidate_freq = 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= DATE SETTINGS ===================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Date]
date.timezone = "Europe/Berlin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= MYSQL / MYSQLI ==================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[MySQLi]
mysqli.allow_persistent = Off
mysqli.max_persistent = 0
mysqli.max_links = 50
mysqli.default_port = 3306

[mysqlnd]
mysqlnd.collect_statistics = Off
mysqlnd.collect_memory_statistics = Off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= PDO =============================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Pdo_mysql]
pdo_mysql.default_socket=

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= MAIL ============================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = Off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= SOAP ============================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[soap]
soap.wsdl_cache_enabled = 1
soap.wsdl_cache_dir = "/tmp"
soap.wsdl_cache_ttl = 86400
soap.wsdl_cache_limit = 5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= ASSERTIONS ======================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Assertion]
zend.assertions = -1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ================= EXTENSIONS ======================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[extension]
; Core & performance
zend_extension=opcache            ; PHP bytecode cache for performance

; Common / essential
extension=curl                   ; HTTP requests, APIs
extension=fileinfo               ; File type detection
extension=gd                     ; Basic image processing
extension=intl                   ; Internationalization (dates, currencies)
extension=mbstring               ; Multibyte (UTF-8) strings
extension=mysqli                 ; MySQL database support
extension=pdo_mysql              ; PDO for MySQL
extension=openssl                ; Encryption, HTTPS, security
extension=zip                    ; ZIP archive handling

; Optional, depending on project
;extension=ldap                  ; LDAP / Active Directory integration
;extension=exif                  ; Image metadata handling (useful for image uploads)
;extension=soap                  ; SOAP web services
;extension=sockets               ; Socket programming, websocket support
;extension=xsl                   ; XSL transformations for XML
;extension=tidy                  ; HTML cleanup / validation
;extension=sodium                ; Modern encryption / cryptography (recommended if app uses it)
;extension=bz2
;extension=ffi
;extension=ftp
;extension=gettext
;extension=gmp
;extension=odbc
;extension=pdo_firebird
;extension=pdo_odbc
;extension=pdo_pgsql
;extension=pdo_sqlite
;extension=pgsql
;extension=shmop
;extension=snmp
;extension=sqlite3
EOF

# /etc/php/$php_version/fpm/pool.d/www.conf — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_2"
[www]
user = www-data
group = www-data
listen = /run/php/php$php_version-fpm.sock
listen.owner = www-data
listen.group = www-data
listen.mode = 0660
pm = dynamic
pm.max_children = 20
pm.start_servers = 4
pm.min_spare_servers = 2
pm.max_spare_servers = 6
clear_env = yes
security.limit_extensions = .php
EOF

    # Services
    systemctl restart apache2

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "⚠️  PHP Version: %s \n" "$(php -r 'echo php_version;')"
}

install_mysql() {
    local TO_INSTALL=( "mysql-server" )

    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: %s \n" "${TO_INSTALL[@]}"

    if apt -y -qq "${TO_INSTALL[@]}"; then
        printf "\e[1;32m"
        printf "✅  Installation successful: %s \n" "${TO_INSTALL[@]}"
    else
        printf "\e[1;31m"
        printf "❌  Installation failed: %s \n" "${TO_INSTALL[@]}"
        return 1
    fi

    # Services
    systemctl enable mysql
    systemctl start mysql
    printf "\e[1;33m"
    printf "⚠️  MySQL Status: %s \n" "$(systemctl is-active mysql)"

    # Security
    local mysql_root_pass="NEW_PASSWORD"
    local mysql_admin_pass="NEW_PASSWORD"

    # Change root passwort
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$mysql_root_pass';"
    mysql -u root -p "$mysql_root_pass" -e "FLUSH PRIVILEGES;"

    # Change login to auth_socket
    mysql -u root -p "$mysql_root_pass" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;"
    mysql -e "FLUSH PRIVILEGES;"

    # Create Admin User
    mysql -e "CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY '$mysql_admin_pass';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;"
    mysql -e "FLUSH PRIVILEGES;"

    # Security script answers 
    printf "\e[1;33m"
    printf "**************************************** \n"
    printf "⚠️  Run 'mysql_secure_installation', give these answers: \n"
    printf "**************************************** \n"
    printf "Validate password strength: STRONG \n"
    printf "Remove anonymous users: y \n"
    printf "Disallow root login remotely: y \n"
    printf "Remove test database and access to it: y \n"
    printf "Reload privilege tables now: y \n"
    printf "**************************************** \n"

    # Security script
    mysql_secure_installation

    # Allow in firewall
    ufw allow mysql

    printf "\e[1;32m"
    printf "✅  Configuration successful: %s \n" "${TO_INSTALL[@]}"
    printf "⚠️  MySQL Version: %s \n" "$(mysql --version | awk '{print $3}' | cut -d',' -f1)"
}

install_grav() {
    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: grav \n"

    # Download & Unzip Grav
    local cms_url="https://getgrav.org/download/core/grav-admin/latest"
    local cms_zip="grav.zip"

    if wget -q "$cms_url" -O "$cms_zip"; then
        printf "\e[1;32m"
        printf "✅  Download successful \n"
    else
        printf "\e[1;31m"
        printf "❌  Download failed \n"
        return 1
    fi

    if unzip -q "$cms_zip"; then
        printf "\e[1;32m"
        printf "✅  Unzip successful \n"
        rm "$cms_zip"
    else
        printf "\e[1;31m"
        printf "❌  Unzip failed \n"
        return 1
    fi

    # Backup
    local conf_file_1="/var/www/html/grav/user/config/system.yaml"
    local conf_file_2="/etc/apache2/sites-available/000-default.conf"

	backup_file "$conf_file_1"
	backup_file "$conf_file_2"

    # Configuration
# /var/www/html/grav/user/config/system.yaml — no leading spaces, EOF at column 0
cat << EOF > "$conf_file_1"
# ===========================
# Grav System Configuration
# Optimized for Production
# ===========================

# Use relative URLs for internal links
absolute_urls: false

# Home page route
home:
alias: '/home'              # Make sure this page exists

# ---------------------------
# Pages Configuration
# ---------------------------
pages:
theme: quark                # Production theme
markdown:
    extra: true             # Enable advanced Markdown features (tables, footnotes, etc.)
process:
    markdown: true          # Parse Markdown in page content
    twig: false             # Disable Twig in content for security

# ---------------------------
# Assets (CSS/JS) Optimization
# ---------------------------
assets:
css_pipeline: true          # Combine CSS files to reduce HTTP requests
css_minify: true            # Minify CSS for smaller size
css_rewrite: true           # Rewrite relative URLs for CSS
js_pipeline: true           # Combine JS files
js_module_pipeline: true    # Combine JS modules
js_minify: true             # Minify JS

# ---------------------------
# Security: HTTPS
# ---------------------------
force_ssl: true             # Redirect HTTP -> HTTPS

# ---------------------------
# Cache Configuration
# ---------------------------
cache:
enabled: true               # Speeds up page load
check:
    method: hash            # Optimal for production, checks file hash only
driver: auto                # Uses the best available caching method

# ---------------------------
# Twig Template Engine
# ---------------------------
twig:
cache: true                 # Speeds up template rendering
debug: false                # Disable debug messages in production
auto_reload: false          # Disable auto-reload, must clear cache on updates
autoescape: true            # Protect against XSS attacks

# ---------------------------
# Error Handling
# ---------------------------
errors:
display: 0                  # Only show simple errors to visitors
log: true                   # Log errors for debugging

# ---------------------------
# Debugger
# ---------------------------
debugger:
enabled: false              # Never enable in live site
censored: true              # Prevent sensitive info exposure if enabled

# ---------------------------
# Session Management
# ---------------------------
session:
enabled: true               # Required for forms/admin
secure: true                # Only send cookies over HTTPS
httponly: true              # Protect cookies from client-side scripts
samesite: Strict            # Prevent cross-site request forgery
split: true                 # Separate admin and site sessions

# ---------------------------
# Strict Mode (Security & Compatibility)
# ---------------------------
strict_mode:
yaml_compat: false          # Disable legacy YAML parsing
twig_compat: false          # Disable legacy Twig features
blueprint_compat: false     # Disable old blueprint behavior

# ---------------------------
# Grav Package Manager (GPM)
# ---------------------------
gpm:
verify_peer: true           # Always verify SSL certificate when downloading packages
EOF

    # Security
    # Protect Admin-Panel Path
    if ! grep -q "<Location /admin>" "$conf_file_2"; then
        sudo sed -i '/ErrorLog[[:space:]]\+\${APACHE_LOG_DIR}\/error\.log/i \
        <Location /admin>\
            Require ip 192.168.1.0/24\
        </Location>\n' "$conf_file_2"
    fi

    # Change Document Root
    sudo sed -i \
    -e 's|^\([[:space:]]*\)DocumentRoot /var/www/html/|\1DocumentRoot /var/www/html/grav/|' \
    -e 's|^\([[:space:]]*\)<Directory /var/www/html/>|\1<Directory /var/www/html/grav/>|' \
    "$conf_file_2"

    # Services
    systemctl reload apache2

    # Permissions
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} +
    find /var/www/html -type f -exec chmod 644 {} +

    printf "\e[1;32m"
    printf "✅  Installation successful: grav \n"
}

install_wordpress() {
    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: wordpress \n"

    # Download & Unzip WordPress
    local cms_url="https://wordpress.org/latest.zip"
    local cms_zip="wordpress.zip"

    if wget -q "$cms_url" -O "$cms_zip"; then
        printf "\e[1;32m"
        printf "✅  Download successful \n"
    else
        printf "\e[1;31m"
        printf "❌  Download failed \n"
        return 1
    fi

    if unzip -q "$cms_zip"; then
        printf "\e[1;32m"
        printf "✅  Unzip successful \n"
        rm "$cms_zip"
    else
        printf "\e[1;31m"
        printf "❌  Unzip failed \n"
        return 1
    fi

    # Create Database
    mysql -e "CREATE DATABASE IF NOT EXISTS db_wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

    # Create WordPress user
    local wordpress_admin_pass="NEW_PASSWORD"

    # Create Admin User
    mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY '$wordpress_admin_pass';"
    mysql -e "GRANT ALL PRIVILEGES ON db_wordpress.* TO 'wordpress'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

    # Backup
    local conf_file_1="/var/www/html/wordpress/wp-config.php"
    local conf_file_2="/etc/apache2/sites-available/000-default.conf"

	backup_file "$conf_file_1"
	backup_file "$conf_file_2"

    # Configuration
    # Edit wp-config.php
    grep -q "DISALLOW_FILE_EDIT" "$conf_file_1" || sed -i "/That's all, stop editing!/i \
    /* Disable File Editing */\n\
    define('DISALLOW_FILE_EDIT', true);\n" "$conf_file_1"

    grep -q "WP_AUTO_UPDATE_CORE" "$conf_file_1" || sed -i "/That's all, stop editing!/i \
    /* Enable Automatic Updates */\n\
    define('WP_AUTO_UPDATE_CORE', true);\n" "$conf_file_1"

    # Protect Admin-Panel Path
    if ! grep -q "<Location /wp-admin>" "$conf_file_2"; then
        sudo sed -i '/ErrorLog[[:space:]]\+\${APACHE_LOG_DIR}\/error\.log/i \
        <Location /wp-admin>\
            Require ip 192.168.1.0/24\
        </Location>\n' "$conf_file_2"
    fi

    # Change Document Root
    sudo sed -i \
    -e 's|^\([[:space:]]*\)DocumentRoot /var/www/html/|\1DocumentRoot /var/www/html/wordpress/|' \
    -e 's|^\([[:space:]]*\)<Directory /var/www/html/>|\1<Directory /var/www/html/wordpress/>|' \
    "$conf_file_2"

    # Services
    systemctl reload apache2

    # Permissions
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} +
    find /var/www/html -type f -exec chmod 644 {} +

    # Protect wp-config.php
    chmod 600 "$conf_file_1"

    printf "\e[1;32m"
    printf "✅  Installation successful: wordpress \n"
}

install_kirby() {
    # Try installing the package
    printf "\e[1;33m"
    printf "⏳  Try installing: kirby \n"

    # Download & Unzip Kirby
    local cms_url="https://github.com/getkirby/kirby/archive/refs/tags/5.3.1.zip"
    local cms_zip="kirby.zip"

    if wget -q "$cms_url" -O "$cms_zip"; then
        printf "\e[1;32m"
        printf "✅  Download successful \n"
    else
        printf "\e[1;31m"
        printf "❌  Download failed \n"
        return 1
    fi

    if unzip -q "$cms_zip"; then
        printf "\e[1;32m"
        printf "✅  Unzip successful \n"
        rm "$cms_zip"
    else
        printf "\e[1;31m"
        printf "❌  Unzip failed \n"
        return 1
    fi

    # Backup
    local conf_file_1="/etc/apache2/sites-available/000-default.conf"

	backup_file "$conf_file_1"

    # Configuration
    # Protect Admin-Panel Path
    if ! grep -q "<Location /panel>" "$conf_file_1"; then
        sudo sed -i '/ErrorLog[[:space:]]\+\${APACHE_LOG_DIR}\/error\.log/i \
        <Location /panel>\
            Require ip 192.168.1.0/24\
        </Location>\n' "$conf_file_1"
    fi

    # Change Document Root
    sudo sed -i \
    -e 's|^\([[:space:]]*\)DocumentRoot /var/www/html/|\1DocumentRoot /var/www/html/kirby/|' \
    -e 's|^\([[:space:]]*\)<Directory /var/www/html/>|\1<Directory /var/www/html/kirby/>|' \
    "$conf_file_1"

    # Services
    systemctl reload apache2
    
    # Permissions
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} +
    find /var/www/html -type f -exec chmod 644 {} +

    printf "✅  Installation successful: kirby \n"
}

# ─── Menu ─────────────────────────────────────────────────────────────────
if_invalid() {
    printf "\e[1;33m"
    printf "⚠️  Invalid response, try again: "
}

print_menu() {
    # App list
    local APPS=(
        "Apache"
        "SSL-Certbot"
        "PHP"
        "MySQL"
        "CMS: Grav"
        "CMS: WordPress"
        "CMS: Kirby"
    )

    # App installer functions
    local INSTALL_CMDS=(
        "install_apache"
        "install_certbot"
        "install_php"
        "install_mysql"
        "install_grav"
        "install_wordpress"
        "install_kirby"
    )

    # Print menu
    printf "\e[1;34m"
    printf "**************************************** \n"
    printf "       🚀  WWW INSTALLER v1.0  🚀        \n"
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
