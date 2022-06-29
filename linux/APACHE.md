# How To - Linux - Tools - Apache2 + PHP (Ubuntu) [^1]

## Installation

```
sudo apt install apache2 apache2-utils
sudo apt install libapache2-mod-php php php-mysql
```

```
sudo php --version
```

```
sudo apt-cache search - names-only ^ php
sudo apt install php-cgi php-cli php-common php-dev php-dom php-gd php-imap php-intl php-json php-ldap php-mbstring php-mcrypt php-opcache php-pear php-pspell php-readline php-soap php-xml php-xmlrpc php-zip
```

## Set User-Rights to Web-Folder

```
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

## Commands

```
sudo systemctl stop apache2
sudo systemctl start apache2
sudo systemctl restart apache2
sudo systemctl reload apache2
sudo systemctl disable apache2
sudo systemctl enable apache2
```

## Set Virtual Host File

```
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName www.domain.com
    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```
sudo a2dissite 000-default.conf
sudo a2ensite 000-default.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

## Set Password Authentication [^2]

```
cd /etc/apache2/
sudo htpasswd -c /etc/apache2/.htpasswd USERNAME
```

```
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName www.domain.com

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

```
sudo apache2ctl configtest
sudo systemctl reload apache2
```




## Monitor Apache Performance Using "mod_status" Module [^3]

```
sudo ls /etc/apache2/mods-enabled
sudo /usr/sbin/a2enmod status

sudo a2dismod status
sudo a2enmod status
```

```
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

```
sudo systemctl reload apache2
```

```
http://www.domain.com/service-status?refresh=5
```

### CSS for "mod_status" [^4]

```
sudo ls /etc/apache2/mods-enabled
sudo /usr/sbin/a2enmod substitute
```

```
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

```
sudo mkdir /var/www/html/other
sudo nano /var/www/html/other/status.css
```

```
sudo systemctl reload apache2
```

```
http://www.domain.com/service-status?refresh=5
```

## Add SSL Certificate

### manually

```
sudo mkdir /etc/apache2/ssl
sudo nano /etc/apache2/ssl/your_domain.crt
sudo nano /etc/apache2/ssl/your_private.key
sudo nano /etc/apache2/ssl/your_chain.crt
```

```
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName www.domain.com
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

```
sudo a2enmod userdir
sudo systemctl reload apache2
```

### with Letsencrypt [^5]

```
sudo apt install certbot python3-certbot-apache
sudo certbot certonly --webroot --webroot-path /var/www/html --agree-tos -m admin@domain.com -d www.domain.com
sudo certbot run --apache
    www.domain.com
    2
    2
```

```
sudo systemctl status certbot.timer
```

```
cd /etc/apache2/sites-available
sudo nano /etc/apache2/sites-available/000-default.conf
```

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName www.domain.com
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

```
sudo a2enmod userdir
sudo systemctl reload apache2
```






[^1]: https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-18-04
[^2]: https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-apache-on-ubuntu-18-04
[^3]: https://www.tecmint.com/ubuntu-apache-mod_status/
[^4]: https://sourceforge.net/projects/pimpapachestat/
[^5]: https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04-de