# BASH

## Linux (Ubuntu)

### Command Overview

```bash
ssh                                             # secure Shell command
exit                                            # exit the current shell session
ls                                              # command to list directories
pwd                                             # print working directory
cd                                              # command to navigate through directories
touch                                           # create blank/empty files
echo                                            # print any text that follows the command
nano                                            # editor
vim                                             # editor
cat                                             # display file contents on the terminal
shred                                           # delete a file completely from a hard disk
mkdir                                           # command used to create directories
cp                                              # copying files
mv                                              # move or rename files
rm                                              # delete files or directories
rmdir                                           # removing empty directories
ln                                              # create symbolic links (shortcuts) to other files
clear                                           # clear the terminal display
```

```bash
finger                                          # displays detailed information about system users
whoami                                          # get the active username
useradd                                         # add a new user (simple)
adduser                                         # add a new user (interactive)
usermod                                         # change existing user data
passwd                                          # create or update passwords for existing users
sudo                                            # command to escalate privileges
su                                              # executes a command under a different user's identity
```

```bash
apt, pacman, yum, rpm                           # Package managers depending on the distribution
man                                             # manual pages for all Linux commands
whatis                                          # find what a command is used for
whereis                                         # locate the binary, source, and manual pages for a command
curl                                            # enables you to connect to and transfer data with a remote server
zip                                             # zip files
unzip                                           # unzip files
wget                                            # download files from the internet
less                                            # display paged outputs in the terminal
```

```bash
head                                            # return the specified number of lines from the top
tail                                            # return the specified number of lines from the bottom
tar                                             # command to extract and compress files
cmp                                             # allows you to check if two files are identical
diff                                            # find the difference between two files
comm                                            # combines the functionality of diff and cmp
sort                                            # sort the content of a file while outputting
find                                            # allows you to search for files and directories based on various criteria
chmod                                           # change file permissions
chown                                           # granting ownership of files or folders
grep                                            # search for a string within an output
awk                                             # search through text files by columns/tabs
```

```bash
ifconfig                                        # display network interfaces and IP addresses
traceroute                                      # trace all the network hops to reach the destination
ip address                                      # display and administer the network configuration of a system
resolvectl status                               # resolve domain names, IPv4 and IPv6 addresses, DNS resource records and services with the systemd-resolved
ping                                            # resolves the domain name into an IP address and starts sending ICMP packages to the destination IP
netstat                                         # display network statistics, monitor network connections, and troubleshoot network issues
ss                                              # dump socket statistics and displays information in similar fashion
iptables                                        # Base firewall for all other firewall utilities to interface with
ufw                                             # Firewall
```

```bash
uname                                           # command to get basic information about the OS
neofetch                                        # displays information about the operating system, software, and hardware
free                                            # displays information about the system's memory usage
df                                              # display disk filesystem information
ps                                              # display active processes
top                                             # view active processes live with their system usage
htop                                            # allows you to interactively monitor your system's vital resources or server processes in real-time
kill                                            # kill active processes by process ID or name
pkill                                           # lets you terminate processes based on their name, user, or other attributes
systemctl                                       # lets users control and manage system services (start, stop, restart, status)
mount                                           # mount file systems
history                                         # displays a list of previously executed commands
alias                                           # create custom shortcuts for your regularly used commands
reboot                                          # safely restarts the operating system
shutdown                                        # safely power off the system
```

### Desktop

#### Updates

```bash
#!/bin/bash

# Update the host
do_Update () {

    apt update
    apt full-upgrade -y
    apt autoclean -y
    apt autoremove -y

    echo "############# HOST UPDATED #############"

}

do_Update
```

#### Bad Service (removable)

```bash
#!/bin/bash

# Remove bad services
remove_badservices () {

    apt --purge nis rsh-client rsh-redone-client talk telnet ldap-utils

    echo "############# BAD SERVICES REMOVED #############"

}

remove_badservices
```

#### Bad Service (disableable)

```bash
#!/bin/bash

# Disable bad services
disable_badservices () {

    local services=(slapd nfs-server rpcbind bind9 vsftpd apache2 dovecot exim cyrus-imap smbd squid snmpd postfix sendmail rsync nis)

    for service in "${services[@]}"; do
        disable_service "$service"
    done

    echo "############# BAD SERVICES DISABLED #############"

}

disable_badservices
```

### Server

```bash
# Server-variables
ip=$(hostname -I)
host="server1"
domain="server1.example.com"
email="admin@example.com"
sshport="22"
```

#### Updates

```bash
#!/bin/bash

# Update the host
do_Update () {

    apt update
    apt full-upgrade -y
    apt autoclean -y
    apt autoremove -y

    echo "############# HOST UPDATED #############"

}

do_Update
```

#### Host Variables

```bash
#!/bin/bash

# Collecting important server-variables
get_Variables () {

    read_host() {
        echo "Please enter [HOSTNAME]:"
        read host
    }

    read_domain() {
        echo "Please enter [FQDN]:"
        read domain
    }

    read_email() {
        echo "Please enter [EMAIL-ADDRESS]:"
        read email
    }

    read_sshport() {
        echo "Please enter [SSH-PORT]:"
        read sshport
    }

    if_invalid() {
        echo "Invalid response, try again!"
    }

    while [ -z "$host" ]
    do
        read_host
    done

    while [ -z "$domain" ]
    do
        read_domain
    done

    while [ -z "$email" ]
    do
        read_email
    done

    while [ -z "$sshport" ]
    do
        read_sshport
    done

    echo "$ip"
    echo "$host"
    echo "$domain"
    echo "$email"
    echo "$sshport"

    while true; do
        read -p "Do you want to proceed? (y/n) " yn

        case $yn in
            [yY] ) break;;
            [nN] ) exit;;
            * ) if_invalid;;
        esac
    done

    echo "############# SERVER VARIABLES COLLECTED #############"

}

get_Variables
```

#### Hostname

```bash
#!/bin/bash

# Change hostname
set_Hostname () {

    hostnamectl set-hostname $host
    sed -i 's|preserve_hostname: false|preserve_hostname: true|g' /etc/cloud/cloud.cfg

    cat << EOF > /etc/hosts

    127.0.0.1	localhost
    127.0.1.1	$host
    $ip $host   $domain

    EOF

    echo "############# HOSTNAME CHANGED #############"

}

set_Hostname
```

#### Timezone

```bash
#!/bin/bash

# Change time-zone and set time-server
set_Time () {

    timedatectl set-timezone Europe/Berlin
    timedatectl
    timedatectl set-ntp on

    cat << EOF > /etc/systemd/timesyncd.conf

    [Time]
    NTP=time.uni-potsdam.de
    FallbackNTP=times.tubit.tu-berlin.de

    EOF

    systemctl restart systemd-timesyncd

    echo "############# TIMEZONE CHANGED #############"

}

set_Time
```

#### Bad Service (removable)

```bash
#!/bin/bash

# Remove bad services
remove_badservices () {

    apt --purge remove xinetd nis yp-tools tftpd atftpd tftpd-hpa telnetd rsh-server rsh-redone-server

    echo "############# BAD SERVICES REMOVED #############"

}

remove_badservices
```

#### SSH

```bash
#!/bin/bash

# Change and secure ssh-port
set_SSH () {

    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original

    cat << EOF > /etc/ssh/sshd_config

    Include /etc/ssh/sshd_config.d/*.conf

    # Other
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
    ChallengeResponseAuthentication no
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

    # Config test
    sshd -t

    systemctl restart ssh

    echo "############# SSH SET #############"

}

set_SSH
```

#### Unattended Upgrades

```bash
#!/bin/bash

# Set unattended upgrades
set_Autoupdate () {

    apt install unattended-upgrades -y
    dpkg-reconfigure -plow unattended-upgrades
    cp /etc/apt/apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades.original

    cat << EOF > /etc/apt/apt.conf.d/50unattended-upgrades

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
    Unattended-Upgrade::Mail "$email";

    EOF

    cp /etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades.original

    cat << EOF > /etc/apt/apt.conf.d/20auto-upgrades

    APT::Periodic::Update-Package-Lists "1";
    APT::Periodic::Unattended-Upgrade "1";
    APT::Periodic::Download-Upgradeable-Packages "1";
    APT::Periodic::AutocleanInterval "7";

    EOF

    unattended-upgrades --dry-run --debug

    echo "############# UNATTENDED UPGRADES SET #############"

}

set_Autoupdate
```

#### Hardening

```bash
#!/bin/bash

# Hardening
do_Hardening () {

    cp /etc/sysctl.conf /etc/sysctl.conf.original

    cat << EOF > /etc/sysctl.conf

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

    # Spoofing protection
    net.ipv4.conf.all.rp_filter = 1
    net.ipv4.conf.default.rp_filter = 1

    # Disable redirects & source routing
    net.ipv4.conf.all.accept_redirects = 0
    net.ipv4.conf.default.accept_redirects = 0
    net.ipv4.conf.all.secure_redirects = 0
    net.ipv4.conf.default.secure_redirects = 0
    net.ipv4.conf.all.accept_source_route = 0
    net.ipv4.conf.default.accept_source_route = 0
    net.ipv4.conf.all.send_redirects = 0
    net.ipv4.conf.default.send_redirects = 0

    # Log suspicious packets
    net.ipv4.conf.all.log_martians = 1
    net.ipv4.conf.default.log_martians = 1

    # SYN flood protection
    net.ipv4.tcp_syncookies = 1

    # Keep TCP sane (no legacy tweaks)
    net.ipv4.tcp_timestamps = 1
    net.ipv4.tcp_sack = 1

    # ICMP protection (no full disable!)
    net.ipv4.icmp_echo_ignore_broadcasts = 1
    net.ipv4.icmp_ignore_bogus_error_responses = 1

    # Disable IP forwarding (VM not router)
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

    sysctl -p

    # Disable IRQ Balance
    cp /etc/default/irqbalance /etc/default/irqbalance.original

    cat << EOF > /etc/default/irqbalance

    ENABLED="0"

    EOF

    # Set Security Limits
    # Protect your system against fork bomb attacks
    cp /etc/security/limits.conf /etc/security/limits.original

    cat << EOF > /etc/security/limits.conf

    #<domain>      <type>  <item>         <value>
    #user1          hard    nproc           100
    #@group1        hard    nproc           20

    EOF

    # Pretend IP spoofing
    cp /etc/host.conf /etc/host.original

    cat << EOF > /etc/host.conf

    order bind,hosts
    nospoof on

    EOF

    echo "############# HARDENED #############"

}

do_Hardening
```

#### UFW

```bash
#!/bin/bash

# UFW
install_UFW () {

    if dpkg -s ufw &>/dev/null; then

    else
        apt install ufw  -y
    fi

    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ntp
    ufw allow ssh
    ufw allow $sshport

    > /var/log/uwf.log

    ufw logging on
    ufw enable
    ufw start
    ufw status

    echo "############# UFW INSTALLED #############"

}

install_UFW
```

### Installation

#### Apache2

```bash
#!/bin/bash

# Apache2
install_Apache2 () {

    if dpkg -s apache2 &>/dev/null; then

    else
        apt install apache2  -y
    fi

    systemctl enable apache2
    systemctl status apache2

    cp /etc/apache2/apache2.conf /etc/apache2/apache2.original

    cat << EOF > /etc/apache2/apache2.conf

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

    systemctl reload apache2

    rm default-ssl.conf
    cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.original

    cat << EOF > /etc/apache2/sites-available/000-default.conf

    <VirtualHost *:80>
        ServerAdmin $email
        ServerName $host
        ServerAlias $domain

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

    # Enable rewrite module (for clean URLs, .htaccess rules)
    a2enmod rewrite

    # Enable headers module (for security headers)
    a2enmod headers

    # Enable deflate module (for compression)
    a2enmod deflate

    cp /etc/apache2/mods-available/deflate.conf /etc/apache2/mods-available/deflate.original

    cat << EOF > /etc/apache2/mods-available/deflate.conf

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

    # Enable expires module (for cache control)
    a2enmod expires

    cp /etc/apache2/mods-available/expires.conf /etc/apache2/mods-available/expires.original

    cat << EOF > /etc/apache2/mods-available/expires.conf

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

    # Enable proxy modules (for reverse proxy)
    a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests

    # Multi-Processing Modules configuration

    cp /etc/apache2/mods-available/mpm_event.conf /etc/apache2/mods-available/mpm_event.original

    cat << EOF > /etc/apache2/mods-available/mpm_event.conf

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

    apache2ctl configtest
    systemctl restart apache2

    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} +
    find /var/www/html -type f -exec chmod 644 {} +

    ufw allow "Apache Full"

    echo "############# APACHE2 INSTALLED #############"

}

install_Apache2
```

##### SSL - HARICA

```bash
#!/bin/bash

# SSL for Apache2 (Manual via HARICA)
install_Apache2_SSL_HARICA_Part1 () {

    # Enable SSL module (for HTTPS)
    a2enmod ssl

    # Create certificate signing request
    cat << EOF > /etc/ssl/csr.conf

    [req]
    distinguished_name = req_distinguished_name
    req_extensions = v3_req
    prompt = no
    utf8 = yes
    [req_distinguished_name]
    C = COUNTRYCODE
    ST = STATE
    L = CITY
    O = ORAGNIZATION
    CN = $domain
    [v3_req]
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = $domain

    EOF

    openssl genrsa -out /etc/ssl/$domain.key 4096
    openssl req -new -out /etc/ssl/$domain.csr -key /etc/ssl/$domain.key -config /etc/ssl/csr.conf

    echo "############# APACHE2 SSL PREPARED #############"

}

install_Apache2_SSL_HARICA_Part1
```

```bash
#!/bin/bash

# SSL for Apache2 (Manual via HARICA)
install_Apache2_SSL_HARICA_Part2 () {

    # Copy Certificates
    cp $domain.fullchain.pem /etc/ssl/$domain.fullchain.pem

    chmod 640 /etc/ssl/csr.conf
    chmod 644 /etc/ssl/$domain.csr
    chmod 640 /etc/ssl/$domain.key
    chmod 644 /etc/ssl/$domain.fullchain.pem

    cat << EOF > /etc/apache2/sites-available/000-default.conf

    <VirtualHost *:80>
        ServerAdmin $email
        ServerName $host
        ServerAlias $domain

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
        RewriteCond %{SERVER_NAME} =$domain
        RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
    </VirtualHost>

    <IfModule mod_ssl.c>
        <VirtualHost *:443>
            ServerAdmin $email
            ServerName $host
            ServerAlias $domain

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
            SSLCertificateFile /etc/ssl/$domain.fullchain.pem
            SSLCertificateKeyFile /etc/ssl/$domain.key
            SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
            SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256
            SSLHonorCipherOrder off

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

    apache2ctl configtest
    systemctl restart apache2

    echo "############# APACHE2 SSL INSTALLED #############"

}

install_Apache2_SSL_HARICA_Part2
```

##### SSL - Let's Encrypt and Certbot

```bash
#!/bin/bash

# SSL for Apache2 (Automatic via Let's Encrypt and Certbot)
install_Apache2_SSL_LETSENCRYPT () {

    # Enable SSL module (for HTTPS)
    a2enmod ssl

    # Install cerbot
    apt install certbot python3-certbot-apache
    certbot --apache

    # Set automatic certificate renewal
    systemctl status certbot.timer
    systemctl enable certbot.timer
    systemctl start certbot.timer
    certbot renew --dry-run

    cat << EOF > /etc/apache2/sites-available/000-default.conf

    <VirtualHost *:80>
        ServerAdmin $email
        ServerName $host
        ServerAlias $domain

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
        RewriteCond %{SERVER_NAME} =$domain
        RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
    </VirtualHost>

    <IfModule mod_ssl.c>
        <VirtualHost *:443>
            ServerAdmin $email
            ServerName $host
            ServerAlias $domain

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
            SSLCertificateFile /etc/letsencrypt/live/$domain/fullchain.pem
            SSLCertificateKeyFile /etc/letsencrypt/live/$domain/privkey.pem
            Include /etc/letsencrypt/options-ssl-apache.conf
            SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
            SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256
            SSLHonorCipherOrder off

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

    apache2ctl configtest
    systemctl restart apache2

    echo "############# APACHE2 SSL INSTALLED #############"

}

install_Apache2_SSL_LETSENCRYPT
```

```
Output

Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator apache, Installer apache
Enter email address (used for urgent renewal and security notices) (Enter 'c' to cancel): admin@example.com
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server at
https://acme-v02.api.letsencrypt.org/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel: A
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Which names would you like to activate HTTPS for?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: www.example.com
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate numbers separated by commas and/or spaces, or leave input blank to select all options shown (Enter 'c' to cancel): Enter
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for www.example.com
Enabled Apache rewrite module
Waiting for verification...
Cleaning up challenges
Created an SSL vhost at /etc/apache2/sites-available/www.example.com-le-ssl.conf
Enabled Apache socache_shmcb module
Enabled Apache ssl module
Deploying Certificate to VirtualHost /etc/apache2/sites-available/www.example.com-le-ssl.conf
Enabling available site: /etc/apache2/sites-available/www.example.com-le-ssl.conf
Deploying Certificate to VirtualHost /etc/apache2/sites-available/www.example.com-le-ssl.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for new sites, or if you're confident your site works on HTTPS. You can undo this change by editing your web server's configuration.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations! You have successfully enabled https://www.example.com
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=www.example.com
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/www.example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/www.example.com/privkey.pem
   Your cert will expire on 2020-07-27. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:
   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

```
Output

certbot.timer - Run certbot twice daily
    Loaded: loaded (/lib/systemd/system/certbot.timer; enabled; vendor preset: enabled)
    Active: active (waiting) since Tue 2020-04-28 17:57:48 UTC; 17h ago
    Trigger: Wed 2020-04-29 23:50:31 UTC; 12h left
    Triggers: ● certbot.service
Apr 28 17:57:48 fine-turtle systemd[1]: Started Run certbot twice daily.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/www.example.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
** DRY RUN: simulating 'certbot renew' close to cert expiry
** (The test certificates below have not been saved.)
Congratulations, all renewals succeeded. The following certs have been renewed: /etc/letsencrypt/live/www.example.com/fullchain.pem (success)
```

> Run SSL Labs Server Test to verify your security improvements under: https://www.ssllabs.com/ssltest/

#### PHP

```bash
#!/bin/bash

# Install PHP
install_PHP () {

    apt install php libapache2-mod-php -y
    apt install php-{common,curl,dom,fpm,gd,imagick,intl,json,mbstring,mysql,opcache,xml,zip} -y

    # show current php-version
    php -v

    # list currently installed modules
    php -m

    # hardening

    # PHP
    cp /etc/php/8.x/fpm/php.ini /etc/php/8.x/fpm/php.original

    cat << EOF > /etc/php/8.x/fpm/php.ini

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

    # PHP-FPM
    cp /etc/php/8.x/fpm/pool.d/www.conf /etc/php/8.x/fpm/pool.d/www.conf.original

    cat << EOF > /etc/php/8.x/fpm/pool.d/www.conf

    [www]
    user = www-data
    group = www-data
    listen = /run/php/php8.x-fpm.sock
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

    systemctl restart apache2

    echo "############# PHP INSTALLED #############"

}

install_PHP
```

#### MYSQL

```bash
#!/bin/bash

# Install MySQL
install_MySQL() {

    # Installation
    apt install mysql-server -y
    systemctl start mysql.service
    systemctl status mysql.service

    # Configuration

    # Change passwort
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'NEW_PASSWORD';"
    mysql -u root -p"NEW_PASSWORD" -e "FLUSH PRIVILEGES;"

    # Change login to auth_socket
    mysql -u root -p"NEW_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;"
    mysql -e "FLUSH PRIVILEGES;"

    # Security script
    mysql_secure_installation

    echo "############# MYSQL INSTALLED #############"
}

install_MySQL
```

```
Output

Securing the MySQL server deployment.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Connecting to MySQL using a blank password.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No: y
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 2
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Skipping password set for root as authentication with auth_socket is used by default.
If you would like to use password authentication instead, this can be done with the "ALTER_USER" command.
See https://dev.mysql.com/doc/refman/8.0/en/alter-user.html#alter-user-password-management for more information.

By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.
 - Removing privileges on test database...
Success.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
All done!
```

##### Create Admin

```bash
#!/bin/bash

# Create Admin User
create_MYSSQL_Admin () {

    # Create user
    mysql -e "CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'NEW_PASSWORD';"
    # Grant full rights to all databases
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;"
    # Apply permissions
    mysql -e "FLUSH PRIVILEGES;"

    echo "############# ADMIN CREATED #############"
}

create_MYSSQL_Admin
```

##### Create User

```bash
#!/bin/bash

# Create User
create_MYSSQL_User () {

    # Create user
    mysql -e "CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY 'NEW_PASSWORD';"
    # Grant full rights to all databases
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' WITH GRANT OPTION;"
    # Apply permissions
    mysql -e "FLUSH PRIVILEGES;"

    echo "############# USER CREATED #############"
}

create_MYSSQL_User
```

#### GRAV CMS

```bash
#!/bin/bash

# Install Grav
install_Grav () {

    # Download Grav
    wget https://getgrav.org/download/core/grav-admin/latest -O grav.zip
    unzip grav.zip -d /var/www/html

    # Ownership and Permissions
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} +
    find /var/www/html -type f -exec chmod 644 {} +

    # Configuration
    cp /var/www/html/grav/user/config/system.yaml /var/www/html/grav/user/config/system.original

    cat << EOF > /var/www/html/grav/user/config/system.yaml

    # ===========================
    # Grav System Configuration
    # Optimized for Production
    # ===========================

    # Use relative URLs for internal links
    absolute_urls: false

    # Home page route
    home:
    alias: '/home'   # Make sure this page exists

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

    # Protect Admin-Panel Path
    FILE="/etc/apache2/sites-available/000-default.conf"

    if ! grep -q "<Location /admin>" "$FILE"; then
        sudo sed -i '/ErrorLog[[:space:]]\+\${APACHE_LOG_DIR}\/error\.log/i \
        <Location /admin>\
            Require ip 192.168.1.0/24\
        </Location>\n' "$FILE"
        echo "Block inserted."
    else
        echo "Block already exists. Skipping."
    fi

    # Change Document Root
    sudo sed -i \
    -e 's|^\([[:space:]]*\)DocumentRoot /var/www/html/|\1DocumentRoot /var/www/html/grav/|' \
    -e 's|^\([[:space:]]*\)<Directory /var/www/html/>|\1<Directory /var/www/html/grav/>|' \
    /etc/apache2/sites-available/000-default.conf

    systemctl reload apache2

    echo "############# GRAV INSTALLED #############"
}

install_Grav
```

#### WORDPRESS CMS

```bash
#!/bin/bash

# Install Wordpress
install_Wordpress () {

    # Download Wordpress
    wget https://wordpress.org/latest.zip
    unzip latest.zip -d /var/www/html

    # Create Database
    mysql -e "CREATE DATABASE IF NOT EXISTS db_wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

    # Create User
    mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY 'NEW_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON db_wordpress.* TO 'wordpress'@'localhost';"

    # Apply permissions
    mysql -e "FLUSH PRIVILEGES;"

    systemctl reload apache2

    echo "############# WORDPRESS INSTALLED #############"
}

install_Wordpress
```

```bash
#!/bin/bash

# Harden Wordpress
after_install_Wordpress () {

    # Edit wp-config.php
    echo "" >> wp-config.php
    echo "/* Disable File Editing */" >> wp-config.php
    echo "define('DISALLOW_FILE_EDIT', true);" >> wp-config.php
    echo "" >> wp-config.php
    echo "/* Enable Automatic Updates */" >> wp-config.php
    echo "define('WP_AUTO_UPDATE_CORE', true);" >> wp-config.php

    # Protect wp-config.php
    chmod 600 /var/www/html/wordpress/wp-config.php

    # Protect Admin-Panel Path
    FILE="/etc/apache2/sites-available/000-default.conf"

    if ! grep -q "<Location /wp-admin>" "$FILE"; then
        sudo sed -i '/ErrorLog[[:space:]]\+\${APACHE_LOG_DIR}\/error\.log/i \
        <Location /wp-admin>\
            Require ip 192.168.1.0/24\
        </Location>\n' "$FILE"
        echo "Block inserted."
    else
        echo "Block already exists. Skipping."
    fi

    # Change Document Root
    sudo sed -i \
    -e 's|^\([[:space:]]*\)DocumentRoot /var/www/html/|\1DocumentRoot /var/www/html/wordpress/|' \
    -e 's|^\([[:space:]]*\)<Directory /var/www/html/>|\1<Directory /var/www/html/wordpress/>|' \
    /etc/apache2/sites-available/000-default.conf

    systemctl reload apache2

    echo "############# WORDPRESS HARDENED #############"
}

after_install_Wordpress
```

#### KIRBY CMS

```bash
#!/bin/bash

# Install Kirby
install_Kirby () {

    # Download Kirby
    wget https://github.com/getkirby/kirby/archive/refs/tags/5.3.1.zip -O kirby.zip
    unzip kirby.zip -d /var/www/html

    # Protect Admin-Panel Path
    FILE="/etc/apache2/sites-available/000-default.conf"

    if ! grep -q "<Location /panel>" "$FILE"; then
        sudo sed -i '/ErrorLog[[:space:]]\+\${APACHE_LOG_DIR}\/error\.log/i \
        <Location /panel>\
            Require ip 192.168.1.0/24\
        </Location>\n' "$FILE"
        echo "Block inserted."
    else
        echo "Block already exists. Skipping."
    fi

    # Change Document Root
    sudo sed -i \
    -e 's|^\([[:space:]]*\)DocumentRoot /var/www/html/|\1DocumentRoot /var/www/html/kirby/|' \
    -e 's|^\([[:space:]]*\)<Directory /var/www/html/>|\1<Directory /var/www/html/kirby/>|' \
    /etc/apache2/sites-available/000-default.conf

    systemctl reload apache2

    echo "############# KIRBY INSTALLED #############"
}
install_Kirby
```
