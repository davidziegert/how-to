# How To - Typo3 - Security

## Folder Accesss

```
sudo chown -R www-data:www-data /var/www/html/typo3/
sudo find /var/www/html/typo3/ -type d -exec chmod 2775 {} \;
sudo find /var/www/html/typo3/ -type f -exec chmod 0664 {} \;
```

## Access Restrictions

- sudo chmod 750 /var/www/html/typo3/typo3temp/var/log/
- sudo chmod 750 /var/www/html/typo3/typo3temp/var/session/
- sudo chmod 750 /var/www/html/typo3/typo3temp/var/tests/
- sudo chmod 640 /var/www/html/typo3/.git/index
- sudo chmod 640 /var/www/html/typo3/INSTALL.md
- sudo chmod 640 /var/www/html/typo3/INSTALL.txt
- sudo chmod 640 /var/www/html/typo3/ChangeLog
- sudo chmod 640 /var/www/html/typo3/composer.json
- sudo chmod 640 /var/www/html/typo3/composer.lock
- sudo chmod 640 /var/www/html/typo3/vendor/autoload.php
- sudo chmod 640 /var/www/html/typo3/typo3_src/Build/package.json
- sudo chmod 640 /var/www/html/typo3/typo3_src/bin/typo3
- sudo chmod 640 /var/www/html/typo3/typo3_src/INSTALL.md
- sudo chmod 640 /var/www/html/typo3/typo3_src/INSTALL.txt
- sudo chmod 640 /var/www/html/typo3/typo3_src/ChangeLog
- sudo chmod 640 /var/www/html/typo3/typo3_src/vendor/autoload.php
- sudo chmod 640 /var/www/html/typo3/typo3conf/LocalConfiguration.php
- sudo chmod 640 /var/www/html/typo3/typo3conf/AdditionalConfiguration.php
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/core/composer.json
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/core/ext_tables.sql
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/core/Configuration/Services.yaml
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/extbase/ext_typoscript_setup.txt
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/extbase/ext_typoscript_setup.typoscript
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/felogin/Configuration/FlexForms/Login.xml
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/backend/Resources/Private/Language/locallang.xlf
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/backend/Tests/Unit/Utility/Fixtures/clear.gif
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/belog/Configuration/TypoScript/setup.txt
- sudo chmod 640 /var/www/html/typo3/typo3/sysext/belog/Configuration/TypoScript/setup.typoscript

## Limit PHP Functions

```
php -i | grep allow_url_include
allow_url_include => Off => Off
```

## Modify your PHP.ini

```
sudo cp /etc/php/8.1/apache2/php.ini /etc/php/8.1/apache2/php.ini.original
sudo nano /etc/php/8.1/apache2/php.ini
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
zlib.output_compression = Off
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

;;;;;;;;;;;;;;;;;;;
; Resource Limits ;
;;;;;;;;;;;;;;;;;;;

max_execution_time = 240
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
session.cache_limiter = nocache
session.cache_expire = 30
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