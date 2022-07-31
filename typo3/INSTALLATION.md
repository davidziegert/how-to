# How To - Typo3 - Installation

## Requirements

```
sudo apt install apache2
sudo systemctl enable apache2
sudo a2enmod deflate rewrite headers mime expires
sudo systemctl status apache2
```

```
sudo apt install -y php php-{apcu,bcmath,common,mysql,xml,xmlrpc,curl,gd,cli,mbstring,soap,zip,intl,json}
sudo php -v
```             

```
sudo apt install imagemagick
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

CREATE USER 'typo3user'@'localhost' IDENTIFIED BY 'your_password';
CREATE DATABASE typo3;
GRANT ALL PRIVILEGES ON typo3.* TO 'typo3user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## Installation & Configuration

```
sudo apt install wget unzip
```

```
sudo wget https://get.typo3.org/11.5.13/zip
sudo unzip zip
sudo mv typo3_src-11.5.13/ /var/www/html/typo3
sudo rm zip
sudo rm /var/www/html/index.html
```

```
sudo nano /var/www/html/typo3/FIRST_INSTALL
sudo chown -R www-data:www-data /var/www/html/typo3/
sudo find /var/www/html/typo3/ -type d -exec chmod 755 {} \;
sudo find /var/www/html/typo3/ -type f -exec chmod 644 {} \;
```

```
sudo nano /etc/apache2/sites-available/typo3.conf
```

```
<VirtualHost *:80>
	ServerAdmin admin@example.com
	DocumentRoot /var/www/html/typo3
	ServerName example.com
	ServerAlias www.example.com
	
	<Directory /var/www/html/typo3/>
		Options FollowSymlinks
		AllowOverride All
		Require all granted
	</Directory>
	
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```
sudo a2ensite typo3.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
```

```
http://your-server-ip-address
```

![Screenshot-1](/files/typo3_install_1.jpg)
![Screenshot-2](/files/typo3_install_2.jpg)
![Screenshot-3](/files/typo3_install_3.jpg)
![Screenshot-4](/files/typo3_install_4.jpg)
![Screenshot-5](/files/typo3_install_5.jpg)
![Screenshot-6](/files/typo3_install_6.jpg)