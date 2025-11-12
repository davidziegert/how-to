# Apache2 + PHP (Ubuntu) [^1]

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

```bash
sudo apt install apache2 apache2-utils
sudo apt install libapache2-mod-php php php-cli
```

```bash
sudo php --version
```

```bash
sudo apt-cache search - names-only ^ php
sudo apt install php-cgi php-common php-mysql php-dev php-dom php-gd php-imap php-intl php-json php-ldap php-mbstring php-opcache php-pear php-pspell php-readline php-soap php-xml php-xmlrpc php-zip
```

## Set User-Rights to Web-Folder

```bash
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod 755 {} +
sudo find /var/www/html -type f -exec chmod 644 {} +
```

## Commands

```bash
sudo systemctl stop apache2
sudo systemctl start apache2
sudo systemctl restart apache2
sudo systemctl reload apache2
sudo systemctl disable apache2
sudo systemctl enable apache2
```

## Set Virtual Host File

```bash
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin [EMAIL]
    ServerName [URL]

    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```bash
sudo a2dissite 000-default.conf
sudo a2ensite 000-default.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

## Set Access only from subnet

```bash
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin [EMAIL]
    ServerName [URL]

    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    Order Deny,Allow
    Deny from all
    Allow from 141.89.0.0/16
</VirtualHost>
```

```bash
sudo a2dissite 000-default.conf
sudo a2ensite 000-default.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

## Set Password Authentication [^2]

```bash
cd /etc/apache2/
sudo htpasswd -c /etc/apache2/.htpasswd USERNAME
```

```bash
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin [EMAIL]
    ServerName [URL]

    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory "/var/www/html">
      AuthType Basic
      AuthName "Restricted Content"
      AuthUserFile /etc/apache2/.htpasswd
      Require valid-user
  </Directory>
</VirtualHost>
```

```bash
sudo apache2ctl configtest
sudo systemctl reload apache2
```

## Monitor Apache Performance Using "mod_status" Module [^3]

```bash
sudo ls /etc/apache2/mods-enabled
sudo /usr/sbin/a2enmod status

sudo a2dismod status
sudo a2enmod status
```

```bash
sudo nano /etc/apache2/mods-available/status.conf
```

```
<IfModule mod_status.c>
	<Location /server-status>
		SetHandler server-status
		Require local
		Require ip xxx.xxx.xxx.xxx
	</Location>

	ExtendedStatus On

	<IfModule mod_proxy.c>
		ProxyStatus On
	</IfModule>
</IfModule>
```

```bash
sudo systemctl reload apache2
```

```
http://www.domain.com/service-status?refresh=5
```

### CSS for "mod_status" [^4]

```bash
sudo ls /etc/apache2/mods-enabled
sudo /usr/sbin/a2enmod substitute
```

```bash
sudo nano /etc/apache2/mods-available/status.conf
```

```
<IfModule mod_status.c>
	<Location /server-status>
		SetHandler server-status
		Require local
		Require ip 141.89.100.168

		AddOutputFilterByType SUBSTITUTE text/html
		SetOutputFilter SUBSTITUTE;DEFLATE
		Substitute 's|</head>|<style type="text/css">@import "/other/status.css"</style><meta name="viewport" content="width=device-width, initial-scale=1"></head>|'
	</Location>

	ExtendedStatus On

	<IfModule mod_proxy.c>
		ProxyStatus On
	</IfModule>
</IfModule>
```

```bash
sudo mkdir /var/www/html/other
sudo nano /var/www/html/other/status.css
```

```bash
sudo systemctl reload apache2
```

```
http://www.domain.com/service-status?refresh=5
```

## Add SSL Certificate

### manually

```bash
sudo mkdir /etc/apache2/ssl
sudo nano /etc/apache2/ssl/your_domain.crt
sudo nano /etc/apache2/ssl/your_private.key
sudo nano /etc/apache2/ssl/your_chain.crt
```

```bash
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin [EMAIL]
    ServerName [URL]

    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    RewriteEngine on
    RewriteCond %{SERVER_NAME} = www.domain.com
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>

<IfModule mod_ssl.c>
	<VirtualHost *:443>
		SSLEngine on
        SSLCertificateFile /etc/apache2/ssl/your_domain.crt
        SSLCertificateKeyFile /etc/apache2/ssl/your_private.key
        SSLCertificateChainFile /etc/apache2/ssl/your_chain.crt
	</VirtualHost>
</IfModule>
```

```bash
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers
sudo systemctl reload apache2
```

### with Letsencrypt [^5]

```bash
sudo apt install certbot python3-certbot-apache
sudo certbot certonly --webroot --webroot-path /var/www/html --agree-tos -m admin@domain.com -d www.domain.com
sudo certbot run --apache
    www.domain.com
    2
```

```bash
sudo systemctl status certbot.timer
```

```bash
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin [EMAIL]
    ServerName [URL]

    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    RewriteEngine on
    RewriteCond %{SERVER_NAME} = www.domain.com
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>

<IfModule mod_ssl.c>
	<VirtualHost *:443>
		SSLEngine on
		SSLCertificateFile /etc/letsencrypt/live/www.domain.com/fullchain.pem
		SSLCertificateKeyFile /etc/letsencrypt/live/www.domain.com/privkey.pem
		Include /etc/letsencrypt/options-ssl-apache.conf
	</VirtualHost>
</IfModule>
```

```bash
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers
sudo systemctl reload apache2
```

## Hardening

```bash
sudo nano /etc/apache2/apache2.conf
```

```
# Specifies the default directory where Apache stores runtime files, such as process ID (PID) files
# and lock files during its operation.
DefaultRuntimeDir ${APACHE_RUN_DIR}

# PidFile: The file in which the server should record its process identification number when it starts.
# This needs to be set in /etc/apache2/envvars
PidFile ${APACHE_PID_FILE}

# Timeout: The number of seconds before receives and sends time out.
Timeout 300

# KeepAlive: Whether or not to allow persistent connections (more than one request per connection).
# Set to "Off" to deactivate.
KeepAlive On

# MaxKeepAliveRequests: The maximum number of requests to allow # during a persistent connection.
# Set to 0 to allow an unlimited amount. We recommend you leave this number high, for maximum performance.
MaxKeepAliveRequests 100

# KeepAliveTimeout: Number of seconds to wait for the next request from the same client on the same connection.
KeepAliveTimeout 5

# These need to be set in /etc/apache2/envvars
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}

# HostnameLookups: Log the names of clients or just their IP addresses e.g., www.apache.org (on) or 204.62.129.132 (off).
# The default is off because it'd be overall better for the net if people had to knowingly turn this feature on, since enabling it means that each client request will result in AT LEAST one lookup request to the nameserver.
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

# Sets the default security model of the Apache2 HTTPD server. It does not allow access to the root filesystem outside of /usr/share and /var/www.

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

# AccessFileName: The name of the file to look for in each directory for additional configuration directives.  See also the AllowOverride directive.
AccessFileName .htaccess

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

# Include the virtual host configurations
IncludeOptional sites-enabled/*.conf
```

## ModSecurity [^6]

```bash
sudo apt install libapache2-mod-security2 -y
sudo a2enmod security2
sudo cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf 
sudo sed -i 's|SecRuleEngine DetectionOnly|SecRuleEngine On|g' /etc/modsecurity/modsecurity.conf 
sudo sed -i 's|SecAuditLogParts ABDEFHIJZ|SecAuditLogParts ABCEFHJKZ|g' /etc/modsecurity/modsecurity.conf 
sudo mkdir /etc/apache2/modsecurity/
sudo wget https://github.com/coreruleset/coreruleset/archive/refs/tags/v4.20.0.tar.gz
sudo tar xvf v4.20.0.tar.gz -C /etc/apache2/modsecurity
sudo cp /etc/apache2/modsecurity/coreruleset-4.20.0/crs-setup.conf.example /etc/apache2/modsecurity/coreruleset-4.20.0/crs-setup.conf
sudo nano /etc/apache2/mods-enabled/security2.conf
```

```
<IfModule security2_module>
    # Default Debian dir for modsecurity's persistent data
    SecDataDir /var/cache/modsecurity

    # Include all the *.conf files in /etc/modsecurity.
    IncludeOptional /etc/modsecurity/*.conf

    # Include OWASP ModSecurity CRS rules if installed
    Include /etc/apache2/modsecurity/coreruleset-4.20.0/crs-setup.conf
    Include /etc/apache2/modsecurity/coreruleset-4.20.0/rules/*.conf
</IfModule>
```

```bash
sudo systemctl restart apache2
```

[^1]: https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-18-04
[^2]: https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-apache-on-ubuntu-18-04
[^3]: https://www.tecmint.com/ubuntu-apache-mod_status/
[^4]: https://sourceforge.net/projects/pimpapachestat/
[^5]: https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04-de
[^6]: https://linuxcapable.com/how-to-install-modsecurity-with-apache-on-ubuntu-linux/
