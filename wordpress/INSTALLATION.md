# How To - Wordpress - Installation

## Requirements

```
sudo apt install apache2
sudo systemctl enable apache2
sudo a2enmod rewrite
sudo systemctl status apache2
```

```
sudo apt install -y php php-{bcmath,common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}
sudo php -v
```

```
sudo apt install mariadb-server mariadb-client
sudo systemctl enable --now mariadb
sudo systemctl status mariadb
```

```
sudo mysql_secure_installation

Enter current password for root (enter for none): Press ENTER
Set root password? [Y/n]: Y
New password: Set-your-new-password
Re-enter new password: Set-your-new-password
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

```
sudo mysql -u root -p

CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'your_password';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## Installation & Configuration

```
sudo apt install wget unzip
```

```
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv wordpress/ /var/www/html/
sudo rm latest.zip
sudo rm /var/www/html/index.html
```

```
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo find /var/www/html/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/html/wordpress/ -type f -exec chmod 640 {} \;
```

```
sudo nano /etc/apache2/sites-available/wordpress.conf
```

```
<VirtualHost *:80>
	ServerAdmin admin@example.com
	DocumentRoot /var/www/html/wordpress
	ServerName example.com
	ServerAlias www.example.com
	
	<Directory /var/www/html/wordpress/>
		Options FollowSymLinks
		AllowOverride All
		Require all granted
	</Directory>
	
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```
sudo a2ensite wordpress.conf
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

```
http://your-server-ip-address
```

![Screenshot-1](/files/wordpress_install_1.jpg)
![Screenshot-2](/files/wordpress_install_2.jpg)
![Screenshot-3](/files/wordpress_install_3.jpg)
![Screenshot-4](/files/wordpress_install_4.jpg)
![Screenshot-5](/files/wordpress_install_5.jpg)
![Screenshot-6](/files/wordpress_install_6.jpg)
![Screenshot-7](/files/wordpress_install_7.jpg)
