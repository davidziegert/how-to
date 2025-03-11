# WordPress

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
```

## Requirements

### Webserver

```bash
sudo apt install apache2
sudo a2enmod rewrite
sudo systemctl enable apache2
sudo systemctl restart apache2
sudo systemctl status apache2
```

```bash
sudo apt install -y php php-{bcmath,common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}
sudo php -v
```

### Database

```bash
sudo apt install mariadb-server mariadb-client
sudo systemctl enable --now mariadb
sudo systemctl status mariadb
```

```bash
sudo mysql_secure_installation

Enter current password for root (enter for none): Press ENTER
Set root password? [Y/n]: Y
New password: [PASSWORD]
Re-enter new password: [PASSWORD]
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

```bash
sudo mysql -u root -p

CREATE USER '[USER]'@'localhost' IDENTIFIED BY '[PASSWORD]';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO '[USER]'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## Installation & Configuration

```bash
sudo apt install wget unzip
```

```bash
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv wordpress/ /var/www/html/
sudo rm latest.zip
sudo rm /var/www/html/index.html
```

```bash
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo find /var/www/html/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/html/wordpress/ -type f -exec chmod 640 {} \;
```

```bash
sudo nano /etc/apache2/sites-available/wordpress.conf
```

```
<VirtualHost *:80>
	ServerAdmin [EMAIL]
	DocumentRoot /var/www/html/wordpress
	ServerName [URL]

	<Directory /var/www/html/wordpress/>
		Options FollowSymLinks
		AllowOverride All
		Require all granted
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```bash
sudo a2ensite wordpress.conf
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo apachectl configtest
sudo systemctl restart apache2
sudo systemctl status apache2
```

> **Note:**
> http://[IPADDRESS]

![Screenshot-1](./assets/wordpress_install_1.jpg)
![Screenshot-2](./assets/wordpress_install_2.jpg)
![Screenshot-3](./assets/wordpress_install_3.jpg)
![Screenshot-4](./assets/wordpress_install_4.jpg)
![Screenshot-5](./assets/wordpress_install_5.jpg)
![Screenshot-6](./assets/wordpress_install_6.jpg)
![Screenshot-7](./assets/wordpress_install_7.jpg)

## Security & Performance

### Folder Accesss

```bash
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo find /var/www/html/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/html/wordpress/ -type f -exec chmod 640 {} \;
```

### PHP

```bash
sudo cp /etc/php/8.*/apache2/php.ini /etc/php/8.*/apache2/php.ini.original
sudo cp /etc/php/8.*/fpm/php.ini /etc/php/8.*/fpm/php.ini.original

sudo nano /etc/php/8.*/apache2/php.ini
sudo nano /etc/php/8.*/fpm/php.ini
```

```
;;;;;;;;;;;
; EXAMPLE ;
;;;;;;;;;;;

[PHP]

;;;;;;;;;;;;;;;;;;;;
; Language Options ;
;;;;;;;;;;;;;;;;;;;;

engine = On
short_open_tag = Off
precision = 14
output_buffering = Off
zlib.output_compression = On
zlib.output_compression_level = 5
implicit_flush = Off
serialize_precision = -1
disable_functions = allow_url_fopen,curl_exec,curl_multi_exec,exec,openlog,parse_ini_filew_source,passthru,phpinfo,popen,proc_open,shell_exec,show_source,syslog,system,highlight_file,fopen_with_path,dbmopen,dbase_open,putenv,chdir,filepro,filepro_rowcount,filepro_retrieve,posix_mkfifo
zend.enable_gc = On
zend.exception_ignore_args = On
zend.exception_string_param_max_len = 0
cgi.force_redirect= On

;;;;;;;;;;;;;;;;;
; Miscellaneous ;
;;;;;;;;;;;;;;;;;

expose_php = Off
allow_webdav_methods = Off
max_input_vars = 1500
realpath_cache_size = 16M
realpath_cache_ttl = 120
opcache.enable = 1
zend_extension = opcache

;;;;;;;;;;;;;;;;;;;
; Resource Limits ;
;;;;;;;;;;;;;;;;;;;

max_execution_time = 360
max_input_time = 60
memory_limit = 512M

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Error handling and logging ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

error_reporting = E_ALL
display_errors = Off
display_startup_errors = Off
log_errors = On
error_log = /var/log/apache2/php_scripts_error.log
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = Off
html_errors = Off

;;;;;;;;;;;;;;;;;
; Data Handling ;
;;;;;;;;;;;;;;;;;

variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 100M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"

;;;;;;;;;;;;;;;;;;;;;;;;;
; Paths and Directories ;
;;;;;;;;;;;;;;;;;;;;;;;;;

enable_dl = Off
file_uploads = On
upload_max_filesize = 100M
max_file_uploads = 5

;;;;;;;;;;;;;;;;;;
; Fopen wrappers ;
;;;;;;;;;;;;;;;;;;

allow_url_fopen = Off
allow_url_include = Off
default_socket_timeout = 60

;;;;;;;;;;;;;;;;;;;
; Module Settings ;
;;;;;;;;;;;;;;;;;;;

[CLI Server]
cli_server.color = On

[Date]
date.timezone = Europe/Berlin

[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = Off

[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1

[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.default_port = 3306
mysqli.reconnect = Off

[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = Off

[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0

[bcmath]
bcmath.scale = 0

[Session]
session.save_handler = files
session.save_path = /var/lib/php/sessions
session.use_strict_mode = 1
session.use_cookies = 1
session.use_only_cookies = 1
session.name = NEW_SSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_secure = 1
session.cookie_httponly = 1
session.cookie_samesite = Strict
session.serialize_handler = php
session.gc_probability = 0
session.gc_divisor = 1000
session.gc_maxlifetime  = 600
session.cache_limiter = public
session.cache_expire = 180
session.use_trans_sid = 0
session.sid_length = 256
session.trans_sid_tags = "a=href,area=href,frame=src,form="
session.sid_bits_per_character = 6

[Assertion]
zend.assertions = -1

[Tidy]
tidy.clean_output = Off

[soap]
soap.wsdl_cache_enabled = 1
soap.wsdl_cache_dir = "/tmp"
soap.wsdl_cache_ttl = 86400
soap.wsdl_cache_limit = 5

[ldap]
ldap.max_links = -1
```

### Wordpress

#### Block Userlist in WP’s REST API

A list all of all is available at users https://example.com/wp-json/wp/v2/users and one can also get information about a specific user at https://example.com/wp-json/wp/v2/users/1, where 1 is a user’s ID. To disable these add this code snippet to your theme’s functions.php file.

```php
/* ******************* */
/* Block WP-JSON-Users */
/* ******************* */

add_filter('rest_endpoints', function ($endpoints) {
    if (isset($endpoints['/wp/v2/users'])) {
        unset($endpoints['/wp/v2/users']);
    }
    if (isset($endpoints['/wp/v2/users/(?P<id>[\d]+)'])) {
        unset($endpoints['/wp/v2/users/(?P<id>[\d]+)']);
    }
    return $endpoints;
});
```

#### Remove WP-Admin Login-Path

Are you looking for a simple, yet effective way to protect your admin page? If so, you can use the WPS Hide Login plugin to change the location of the login page.
The most popular method to break into a website is brute force (continually entering login information until it is right).
Redirect the the login page to another URL with the WPS Hide Login Plugin.

## Backup

### Files

```bash
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   tar -cvf backup_wordpress_$(date "+%d-%b-%y").tar /var/www/html/wordpress
```

### Database

#### Database

```bash
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   mysqldump -u [USERNAME] -p [DATABASE] > backup_wordpress_$(date "+%d-%b-%y").sql
```

### via Plugin

- #### [UpdraftPlus](https://de.wordpress.org/plugins/updraftplus/)
- #### [BackWPup](https://de.wordpress.org/plugins/backwpup/)
- #### [VaultPress](https://de.wordpress.org/plugins/vaultpress/)

### Export Data (no Backup!)

![Screenshot-1](./assets/wordpress_export.jpg)

## Themes

### Classic Theme [Download](./assets/wp_classic.zip)

#### Folder Structure Example

![Screenshot-17](./assets/wordpress_structure.jpg)

```
theme
├── css
│	└── custom.css
├── js
│	└── script.js
├── img
│	├── favicon.ico
│	└── logo.png
├── 404.php					// 404 Page-Template
├── archive.php				// Archive Page-Template
├── author.php				// Author Page-Template
├── category.php			// Category Page-Template
├── comments.php			// Comments Template-Part
├── footer.php				// Footer Template-Part
├── front-page.php			// Static Front-Page-Template
├── functions.php			// WordPress-Functions
├── header.php				// Header Template-Part
├── home.php				// Blog Home Page-Template
├── index.php				// Global Page-Template
├── main.php				// Content Template-Part
├── nav.php					// Navigation Template-Part
├── page.php				// Site Page-Template
├── screenshot.png			// Default-Screenshot
├── search.php				// Search-Result Page-Template
├── searchform.php			// Search-Form Template-Part
├── sidebar.php				// Sidebar Template-Part
├── single.php				// Blog-Entry Page-Template
└── style.css				// Default-Stylesheet and Theme Information
```

### FSE Theme [^1] [Download](./assets/wp_fse.zip)

#### Folder Structure Example [^2]

```
theme
├── parts
│	├── footer.html                     // Global Footer Block-Part
│	├── sidebar.html                    // Sidebar Block-Part
│	└── header.html                     // Global Header Block-Part
├── patterns
│	└── example.php                     // Custom Blocks
├── styles
│	└── example.json                    // Alternative Settings and Styles
├── templates
│	├── 404.html                        // 404 Page-Template
│	├── archive.html                    // To show list of posts
│	├── category-uncategorized.html     // Template for specific category Page-Template
│	├── front-page.html                 // Default-FrontPage Page-Template
│	├── home.html                       // Default Page-Template
│	├── index.html                      // Primary template to show page or post like index.php in classic themes
│	├── page.html                       // Site Page-Template
│	├── search.html                     // Search-Result Page-Template
│	└── single.html                     // Template to show single page or post like single.php
├── functions.php			            // WordPress-Functions
├── screenshot.png			            // Default-Screenshot
├── style.css				            // Default-Theme Information
├── index.php				            // Required generic template file
└── theme.json				            // Global Settings and Styles
```

## Plugins

- [WPS Hide Login](https://de.wordpress.org/plugins/wps-hide-login/)
- [wp_head() cleaner](https://de.wordpress.org/plugins/wp-head-cleaner/)
- [WP Fastest Cache](https://de.wordpress.org/plugins/wp-fastest-cache/)
- [Very Simple Meta Description](https://wordpress.org/plugins/very-simple-meta-description/)
- [Real Media Library](https://de.wordpress.org/plugins/real-media-library-lite/)
- [Polylang](https://de.wordpress.org/plugins/polylang/)
- [Insert PHP Code Snippet](https://de.wordpress.org/plugins/insert-php-code-snippet/)
- [Nested Pages](https://de.wordpress.org/plugins/wp-nested-pages/)
- [Health Check & Troubleshooting](https://wordpress.org/plugins/health-check/)

[^1]: https://fullsiteediting.com/lessons/creating-block-based-themes/
[^2]: https://developer.wordpress.org/themes/core-concepts/theme-structure/
