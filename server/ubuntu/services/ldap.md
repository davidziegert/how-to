# openLDAP (Ubuntu) [^1] [^2] [^3] [^4]

```
Hostname = ldap
DC local IP Address = xxx.xxx.xxx.xxx
Authentication Domain = subdomain.domain.local
Top level Domain = domain.local
```

## Prerequisites

### Set Hostname

```bash
sudo hostnamectl set-hostname ldap
sudo nano /etc/cloud/cloud.cfg
```

```
FROM: preserve_hostname: false
TO: preserve_hostname: true
```

```bash
sudo nano /etc/hosts
```

```
127.0.0.1 localhost
xxx.xxx.xxx.xxx ldap.subdomain.domain.local ldap
```

```bash
sudo hostnamectl
```

## Installation (Server)

```bash
sudo apt install slapd ldap-utils
sudo dpkg-reconfigure slapd
```

```
No
subdomain.domain.local
subdomain
[PASSWORD]
No
Yes
```

```bash
sudo systemctl status slapd
sudo slapd -V
```

```bash
sudo ufw allow ldap
sudo ufw allow ldaps
```

### Test status and connection

```bash
sudo systemctl restart slapd
sudo systemctl status slapd
sudo ldapsearch -x -b dc=subdomain,dc=domain,dc=local -D "cn=admin,dc=subdomain,dc=domain,dc=local" -W
```

### Import Schema for SAMBA

```bash
cd /etc/ldap/schema
sudo wget https://github.com/mwaeckerlin/openldap/raw/refs/heads/master/samba.schema
sudo nano /etc/ldap/slapd.conf
```

```
Download and import locally if you cant copy from SAMBA
```

```bash
cd /etc/ldap/schema
sudo wget https://raw.githubusercontent.com/zentyal/samba/refs/heads/master/examples/LDAP/samba.ldif
sudo ldapadd -x -D "cn=admin,dc=subdomain,dc=domain,dc=local" -W -H ldapi:/// -f samba.ldif
```

```
include /etc/ldap/schema/samba.schema
include /etc/ldap/schema/misc.schema
```

[^1]: https://computingforgeeks.com/install-and-configure-openldap-server-ubuntu/
[^2]: https://computingforgeeks.com/secure-ldap-server-with-ssl-tls-on-ubuntu/
[^3]: https://computingforgeeks.com/install-and-configure-ldap-account-manager-on-ubuntu/
[^4]: https://www.baeldung.com/linux/ldap-command-line-authentication

## LAM - LDAP Acount Manager

### Installation

```bash
sudo apt install apache2 php php-cgi libapache2-mod-php php-mbstring php-common php-pear
```

```bash
sudo php -v
sudo apt install install php*-fpm
```

```bash
sudo a2enconf php*-cgi
sudo systemctl reload apache2
```

```bash
sudo ufw allow http
sudo ufw allow https
```

```bash
sudo apt install ldap-account-manager
```

```bash
sudo nano /etc/apache2/conf-enabled/ldap-account-manager.conf
```

```
#Require all granted
Require ip 127.0.0.1 192.168.10.0/24 192.168.18.0/24
```

```bash
sudo rm /var/www/html/index.html
sudo nano /var/www/html/index.php
```

```php
<?php header("Location: http://xxx.xxx.xxx.xxx/lam"); ?>
```

```bash
sudo systemctl restart apache2
```

> **Note:**
> http://your-server-ip-address/lam

### LAM Settings (with SAMBA)

> **Note:**
> password: lam

```
└── LAM Configuration
    └── General
        ├── Server Settings
        |   ├── Server Address: ldap://localhost:389
        |   ├── Enable TLS: NO
        |   ├── Tree View: dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
        |   └── LDAP search limit: -
        ├── Language Settings
        |   ├── Default Language: English
        |   └── Time Zone: London
        ├── Lamdaemon Settings
        |   └── Profile Password: -
        └── Security Settings
            ├── Login Method: fixed list9
            ├── List of authorized users: cn=Manager,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
            └── Profile Password: \*
```

########################## LDAP ########################################

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
sudo apt -y install libnss-ldap libpam-ldap ldap-utils nscd
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
