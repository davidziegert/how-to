# LDAP (Ubuntu) [^1] [^2]

## Installation (Host)

```bash
sudo apt-get install slapd ldap-utils ldapscripts smbldap-tools -y
sudo systemctl status slapd
```

```bash
sudo dpkg-reconfigure slapd
```

```
NO
DIRECTORY.DOMAIN.TLD
ORGANISATION OR DIRECTORY/SUBDOMAIN
PASSWORD
MDB
NO
YES
NO
```	

```
slapcat
```

## LAM - LDAP Acount Manager

```bash
sudo apt -y install apache2 php php-cgi libapache2-mod-php php-mbstring php-common php-pear
sudo a2enconf php*-cgi
sudo systemctl reload apache2
```

```bash
sudo apt -y install ldap-account-manager
```

## LAM Settings

```

```

## LAM Settings (with SAMBA)

```
http://xxx.xxx.xxx.xxx
```

```
LAM Configuration - "General Settings" Change Password - "Server Profiles" Change Password
```

```
General
    Server Settings
        Server Address              ldap://localhost:389
        Enable TLS                  NO
        Tree View                   dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
        LDAP search limit           -
    Language Settings
        Default Language            English
        Time Zone                    London
    Lamdaemon Settings
        -
    Security Settings
        Login Method                fixed list
        List of authorized users    cn=admin,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
        Profile Password            *Change it
```

```
Account Types
    Available Account Types
        Samba Domains               +
```

```
Active Account Types
    User
        LDAP Suffix                 ou=users,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
        List of Attributes          #uid;#givenName;#sn;#uidNumber;#gidNumber
        Identifier                  -
        Additional LDAP filter      -
        Hidden                      -
    Groups
        LDAP Suffix                 ou=groups,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
        List of Attributes          #cn;#gidNumber;#memberUID;#description
        Identifier                  -
        Additional LDAP filter      -
        Hidden                      -
    Samba Domains
        LDAP Suffix                 dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
        List of Attributes          #sambaDomainName;#sambaSID
        Identifier                  -
        Additional LDAP filter      -
        Hidden                      -
```

```
Modules
    Samba Domains
        Available Modules           Samba Domain (sambaDomain) +
    User
        Available Modules           Samba 3 (sambaSamAccount) +
    Groups
        Available Modules           Samba 3 (sambaGroupMapping) +
```

```bash
sudo reboot now
```

```
http://xxx.xxx.xxx.xxx
```

```
The following suffixes are missing from LDAP. LAM can create them for you. 
You can set the LDAP suffixes for all account types in the LAM server profile on the Account Types tab.
ou=users,dc=SUBDOMAIN,dc=DOMAIN,dc=TLDou=groups,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
```

### Block Access from Outside

```bash
sudo nano /etc/apache2/conf-enabled/ldap-account-manager.conf
```

```
Alias /lam /usr/share/ldap-account-manager

<Directory /usr/share/ldap-account-manager>
	Options +FollowSymLinks
	AllowOverride All
	Require ip xxx.xxx.xxx.0/24
	DirectoryIndex index.html
</Directory>

<Directory /var/lib/ldap-account-manager/tmp>
	Options -Indexes
</Directory>

<Directory /var/lib/ldap-account-manager/tmp/internal>
	Options -Indexes
	Require all denied
</Directory>

<Directory /var/lib/ldap-account-manager/sess>
	Options -Indexes
	Require all denied
</Directory>

<Directory /var/lib/ldap-account-manager/config>
	Options -Indexes
	Require all denied
</Directory>

<Directory /usr/share/ldap-account-manager/lib>
	Options -Indexes
	Require all denied
</Directory>

<Directory /usr/share/ldap-account-manager/help>
	Options -Indexes
	Require all denied
</Directory>

<Directory /usr/share/ldap-account-manager/locale>
	Options -Indexes
	Require all denied
</Directory>
```

### PHP Redirect (optional)

```bash
sudo rm /var/www/html/index.html
sudo nano /var/www/html/index.php
```

```
<?php header("Location: http://xxx.xxx.xxx.xxx/lam"); ?>
```

```bash
sudo systemctl reload apache2
```

## Self-Service-Password (optional) [^3]

```bash
sudo nano /etc/apt/sources.list.d/ltb-project.list
```

```
deb [arch=amd64] https://ltb-project.org/debian/stable stable main
```

```bash
sudo wget -O - https://ltb-project.org/wiki/lib/RPM-GPG-KEY-LTB-project | sudo apt-key add -
sudo apt update
sudo apt install self-service-password
sudo nano /etc/apache2/sites-available/self-service-password.conf
```

```
<VirtualHost *:80>
	ServerName xxx.xxx.xxx.xxx
	DocumentRoot /usr/share/self-service-password/htdocs
	DirectoryIndex index.php
	AddDefaultCharset UTF-8

	<Directory /usr/share/self-service-password/htdocs>
		AllowOverride None

		<IfVersion >= 2.3>
			Require all granted
		</IfVersion>

		<IfVersion < 2.3>
			Order Deny,Allow
			Allow from all
		</IfVersion>
	</Directory>

	Alias /rest /usr/share/self-service-password/rest

	<Directory /usr/share/self-service-password/rest>
		AllowOverride None

		<IfVersion >= 2.3>
			Require all denied
		</IfVersion>

		<IfVersion < 2.3>
			Order Deny,Allow
			Deny from all
		</IfVersion>
	</Directory>

	LogLevel warn
	ErrorLog /var/log/apache2/ssp_error.log
	CustomLog /var/log/apache2/ssp_access.log combined
</VirtualHost>
```

```bash
sudo nano /usr/share/self-service-password/conf/config.inc.local.php
```

```php
<?php

    # Override deault config.inc.php parameters
    # Default language

    $lang = "de";

    # Display menu on top

    $show_menu = true;

    # Display help messages
    # $show_help = true;
    # Extra messages

    $messages['passwordchangedextramessage'] = "Glückwunsch!";
    $messages['changehelpextramessage'] = "Sag wenn was nicht klappt";

    # Logo in /usr/share/self-service-password/htdocs/images

    $logo = "images/ltb-logo.png";

    # Wallaper in /usr/share/self-service-password/htdocs/images

    $background_image = "images/wallpaper.jpg";

    # CSS /usr/share/self-service-password/htdocs/css

    $custom_css = "css/custom.css";

    # Footer

    $display_footer = false;

    # Debug mode

    $debug = false;

    # Encryption, decryption keyphrase, required if $use_tokens = true and $crypt_tokens = true, or $use_sms, or $crypt_answer
    # Please change it to anything long, random and complicated, you do not have to remember it
    # Changing it will also invalidate all previous tokens and SMS codes

    $keyphrase = "#PASSWORT";

    # Invalid characters in login
    # Set at least "*()&|" to prevent LDAP injection
    # If empty, only alphanumeric characters are accepted

    $login_forbidden_chars = "*()&|";

    # Hide some messages to not disclose sensitive information
    # These messages will be replaced by badcredentials error

    $obscure_failure_messages = array("mailnomatch");

    # You may want to limit number of tries per user/ip in a short time (especially with sms option).
    # If you enable this defaults are 2 tries per login and per hour, and same for ip address:

    $enable_ratelimit = true;

    # To require a captcha, set $use_captcha

    $use_captcha = true;

    # LDAP

    $ldap_url = "ldap://localhost:389";
    $ldap_starttls = false;
    $ldap_binddn = "cn=admin,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD";
    $ldap_bindpw = '#PASSWORT';
    $ldap_base = "dc=SUBDOMAIN,dc=DOMAIN,dc=TLD";
    $ldap_login_attribute = "uid";
    $ldap_fullname_attribute = "cn";
    $ldap_filter = "(&(objectClass=person)($ldap_login_attribute={login}))";
    $ldap_use_exop_passwd = true;
    $ldap_use_ppolicy_control = true;

    # Hash mechanism for password:
    # SSHA, SSHA256, SSHA384, SSHA512
    # SHA, SHA256, SHA384, SHA512
    # SMD5
    # MD5
    # CRYPT
    # clear (the default)
    # auto (will check the hash of current password)
    # This option is not used with ad_mode = true

    $hash = "SSHA";

    # Local password policy

    $pwd_min_length = 0;
    $pwd_max_length = 0;
    $pwd_min_lower = 0;
    $pwd_min_upper = 0;
    $pwd_min_digit = 0;
    $pwd_min_special = 0;
    $pwd_forbidden_chars = "@%";
    $pwd_no_reuse = true;
    $pwd_diff_login = true;
    $pwd_complexity = 0;
    $use_pwnedpasswords = false;
    $pwd_show_policy = "never";
    $pwd_show_policy_pos = "above";
    $pwd_no_special_at_ends = false;
    $who_change_password = "user";

    # Reset by questions
    $use_questions = false;

    # $question_populate_enable = false;
    # $answer_attribute = "description";
    # $answer_objectClass = "extensibleObject";
    # $crypt_answers = true;
    # $messages['questions']['ice'] = "What the name of your brother?";

    # Reset by SMS
    $use_sms = false;

    # Reset by mail tokens (sendmail and phpmailer don't work, if there is no correct dns name)
    $use_tokens = false;

    # $question_populate_enable = false;
    # $mail_address_use_ldap = true;
    # $crypt_tokens = true;
    # $token_lifetime = "7200";

    # Mail (sendmail and phpmailer don't work, if there is no correct dns name)
    # PHPMailer configuration (see https://github.com/PHPMailer/PHPMailer)

    $use_mail = false;

    # $mail_attribute = "mail";
    # $mail_from = "password@localhost.com";
    # $mail_from_name = "Self Service Password Administrator";
    # $mail_signature = "Best";
    # $notify_on_change = true;
    # $mail_sendmailpath = '/usr/share/sendmail';
    # $mail_protocol = 'smtp';
    # $mail_smtp_debug = 0;
    # $mail_debug_format = 'html';
    # $mail_smtp_host = 'localhost';
    # $mail_smtp_auth = false;
    # $mail_smtp_user = '';
    # $mail_smtp_pass = '';
    # $mail_smtp_port = 25;
    # $mail_smtp_timeout = 30;
    # $mail_smtp_keepalive = false;
    # $mail_smtp_secure = 'tls';
    # $mail_smtp_autotls = true;
    # $mail_smtp_options = array();
    # $mail_contenttype = 'text/plain';
    # $mail_wordwrap = 0;
    # $mail_charset = 'utf-8';
    # $mail_priority = 3;
?>
```

## Secure OpenLDAP [^4] [^5]

### Generate Self-Signed SSL Cerificates (Host)

```bash
sudo mkdir ldap_ssl 
cd ldap_ssl
sudo openssl genrsa -aes128 -out ldap_server.key 4096
```

```
Enter pass phrase for ldap_server.key: <Set passphrase>
Verifying - Enter pass phrase for ldap_server.key: <Confirm passphrase>
```

```bash
sudo openssl rsa -in ldap_server.key -out ldap_server.key
sudo openssl req -new -days 3650 -key ldap_server.key -out ldap_server.csr 
```

```
Country Name (2 letter code) [AU]:                                  GB
State or Province Name (full name) [Some-State]:                    London
Locality Name (eg, city) []:                                        London
Organization Name (eg, company) [Internet Widgits Pty Ltd]:         MYORGANIZATION
Organizational Unit Name (eg, section) []:                          MYORGANIZATION
Common Name (e.g. server FQDN or YOUR name) []:                     ldap.example.com
Email Address []:                                                   admin@example.com

Please enter the following 'extra' attributes to be sent with your certificate request
A challenge password []:                                            -  
An optional company name []:                                        -
```

```bash
sudo openssl x509 -in ldap_server.csr -out ldap_server.crt -req -signkey ldap_server.key -days 3650
```

### Configure SSL on LDAP Server (Host)

```bash
sudo cp ldap_server.key ldap_server.crt /etc/ldap/sasl2
sudo cp /etc/ssl/certs/ca-certificates.crt /etc/ldap/sasl2
sudo chown -R openldap. /etc/ldap/sasl2
sudo nano /etc/ldap/sasl2/ldap_ssl.ldif
```

```
dn: cn=config
changetype: modify
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/ldap/sasl2/ca-certificates.crt
-
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ldap/sasl2/ldap_server.crt
-
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ldap/sasl2/ldap_server.key
```

```bash
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f ldap_ssl.ldif 
```

```bash
sudo systemctl restart slapd
```

### Configure LDAP Client for TLS/SSL Connection (Client)

```
echo "TLS_REQCERT allow" | sudo tee /etc/ldap/ldap.conf 
```

```bash
sudo nano /etc/ldap.conf
```

```
# Line 259 - OpenLDAP SSL mechanism
ssl start_tls
ssl on
```

## Installation (Client) (with SAMBA)

```bash
sudo apt-get -y install libnss-ldap libpam-ldap ldap-utils nscd
```

```
ldap://xxx.xxx.xxx.xxx
dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
3
NO
NO
```

```bash
sudo nano /etc/nsswitch.conf
```

```
passwd: files ldap
group: files ldap
shadow: files ldap
gshadow: files
hosts: files dns
networks: files
protocols: db files
services: db files
ethers: db files
rpc: db files
netgroup: nis
```

```bash
sudo nano /etc/pam.d/common-password
```

```
password [success=2 default=ignore] pam_unix.so obscure sha512
password [success=1 user_unknown=ignore default=die] pam_ldap.so try_first_pass
password requisite pam_deny.so
password required pam_permit.so
```

[^1]: https://computingforgeeks.com/install-and-configure-openldap-server-ubuntu/
[^2]: https://www.howtoforge.de/anleitung/wie-installiert-und-konfiguriert-man-openldap-und-phpldapadmin-unter-ubuntu-2004/
[^3]: https://self-service-password.readthedocs.io/en/stable/
[^4]: https://computingforgeeks.com/secure-ldap-server-with-ssl-tls-on-ubuntu/
[^5]: https://medium.com/@stsarut/how-to-configure-openldap-with-starttls-mode-on-ubuntu-16-04-3af036b16c6c
