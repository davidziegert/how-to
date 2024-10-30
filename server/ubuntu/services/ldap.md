# openLDAP (Ubuntu)

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
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
127.0.0.1	localhost
127.0.1.1	ldap
[IPADDRESS]	ldap ldap.subdomain.domain.internal
```

```bash
sudo hostnamectl
```

## Installation & (Static)-Configuration (Standalone)

```bash
sudo apt install slapd
sudo systemctl status slapd
sudo slapd -V
```

```bash
sudo ufw allow ldap
sudo ufw allow ldaps
```

### Remove any configuration

```bash
sudo systemctl stop slapd
sudo sed -i "s/SLAPD_CONF=.*/SLAPD_CONF=\/etc\/ldap\/slapd.conf/g" /etc/default/slapd
sudo rm /var/lib/ldap/*.mdb
```

### Generate rootpw

```bash
sudo slappasswd -h {SSHA} -s [PASSWORD]
```

### Download Additional schema

#### RFC2307bis (work only with LAM Pro)

```bash
cd /etc/ldap/schema
sudo wget https://raw.githubusercontent.com/jtyr/rfc2307bis/master/rfc2307bis.schema
```

```
##### Schemas and Object Classes #####

include         /etc/ldap/schema/rfc2307bis.schema
```

#### Samba

```bash
cd /etc/ldap/schema
sudo wget https://github.com/mwaeckerlin/openldap/raw/refs/heads/master/samba.schema
```

```bash
sudo nano /etc/ldap/slapd.conf
```

```
##### Schemas and Object Classes #####

include         /etc/ldap/schema/samba.schema
```

### slapd.conf

```bash
sudo nano /etc/ldap/slapd.conf
```

```
##### Schemas and Object Classes #####

include         /etc/ldap/schema/core.schema
include         /etc/ldap/schema/cosine.schema
include         /etc/ldap/schema/nis.schema
include         /etc/ldap/schema/inetorgperson.schema

##### Loglevel - 256 is a good average #####

loglevel        256
pidfile         /var/run/slapd/slapd.pid
argsfile        /var/run/slapd/slapd.args
modulepath      /usr/lib/ldap
moduleload      back_mdb

##### Return a maximum of 100 values ​​in a search #####

sizelimit       100

##### Number of CPUs used for indexing #####

tool-threads    2

##### Database number #####

database        mdb

##### The base DN #####

suffix          "dc=subdomain,dc=domain,dc=internal"

##### Root user #####

rootdn          "cn=admin,dc=subdomain,dc=domain,dc=internal"
rootpw          "{SSHA}yl1wHc17LnGxtnzhDa0V8ltCN8fp6mcS"

##### Database storage location #####

directory       "/var/lib/ldap"

##### Indices #####

index           objectClass eq

##### Write last modification to the database #####

lastmod         on

##### Access Control Lists #####

include         /etc/ldap/acl.conf
```

### acl.conf

```bash
sudo nano /etc/ldap/acl.conf
```

```
access to attrs=userPassword
    by dn="cn=admin,dc=subdomain,dc=domain,dc=internal" write
    by anonymous auth
    by self write
    by * none
access to *
    by dn="cn=admin,dc=subdomain,dc=domain,dc=internal" write
    by * read
access to dn.base=""
    by * read
```

### Verify \*.conf

```bash
sudo slaptest -f /etc/ldap/slapd.conf -v
```

### Restart services

```bash
sudo systemctl restart slapd
sudo systemctl status slapd
```

### Create Base

```bash
sudo nano /tmp/my-base.ldif
```

```
# Base
dn: dc=subdomain,dc=domain,dc=internal
objectClass: dcObject
objectClass: organization
o: The Name of my domain
dc: subdomain

# Groups
dn: ou=groups,dc=subdomain,dc=domain,dc=internal
ou: groups
objectClass: top
objectClass: organizationalUnit

# BindUser
dn: ou=bindusers,dc=subdomain,dc=domain,dc=internal
ou: binduser
objectClass: top
objectClass: organizationalUnit

# Users
dn: ou=users,dc=subdomain,dc=domain,dc=internal
ou: users
objectClass: top
objectClass: organizationalUnit
```

```bash
ldapadd -x -f /tmp/my-base.ldif -H "ldap://ldap.subdomain.domain.internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]
```

### Create User

```bash
sudo slappasswd -h {SSHA} -s [PASSWORD]
sudo nano /tmp/my-users.ldif
```

```
# Max Mustermann
dn: uid=mustermann,ou=users,dc=subdomain,dc=domain,dc=internal
objectClass: top
objectClass: inetorgperson
objectClass: posixAccount
objectClass: shadowAccount
cn: Max Mustermann
sn: Mustermann
uid: mustermann
uidNumber: 10000
gidNumber: 10000
userPassword: {SSHA}ZjuMLifpQ6Cyn8g1VrXupeWNN1VYNo4I
homeDirectory: /home/mustermann
loginShell: /bin/bash
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0
```

```bash
ldapadd -x -f /tmp/my-users.ldif -H "ldap://ldap.subdomain.domain.internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]
```

### Create Group

```bash
sudo nano /tmp/my-groups.ldif
```

```
# All Users
dn: cn=staff,ou=groups,dc=subdomain,dc=domain,dc=internal
cn: staff
objectClass: top
objectClass: posixGroup
gidNumber: 10000
memberUid: mustermann

# Speacial group
dn: cn=team,ou=groups,dc=subdomain,dc=domain,dc=internal
cn: team
objectClass: top
objectClass: posixGroup
gidNumber: 10001
```

```bash
ldapadd -x -f /tmp/my-groups.ldif -H "ldap://ldap.subdomain.domain.internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]
```

### acl.conf (extended)

```bash
sudo nano /etc/ldap/acl.conf
```

```
##### Access Control Lists #####

##### access to WHAT by WHOM ACCESS #####

##### WHAT = "dn.base","dn.subtree","dn.one","dn.children","filter","attribute", #####

##### WHOM = "dn.base","dn.subtree","dn.one","dn.children","anonym","user","\*","self" #####

##### ACCESS = "none", "disclose", "auth", "compare", "search", "read", "write", "manage" #####

access to dn.base="dc=subdomain,dc=domain,dc=internal"
    by * read

access to attrs=userPassword
    by dn="cn=admin,dc=subdomain,dc=domain,dc=internal" write
    by anonymous auth
    by self write
    by * none

access to dn.subtree="ou=bindusers,dc=subdomain,dc=domain,dc=internal"
    by dn="cn=admin,dc=subdomain,dc=domain,dc=internal" write
    by * none

access to dn.subtree="ou=groups,dc=subdomain,dc=domain,dc=internal"
    by dn="cn=admin,dc=subdomain,dc=domain,dc=internal" write
    by dn.one="ou=bindusers,dc=subdomain,dc=domain,dc=internal" read
    by * none

access to dn.subtree="ou=users,dc=subdomain,dc=domain,dc=internal"
    by dn="cn=admin,dc=subdomain,dc=domain,dc=internal" write
    by dn.one="ou=bindusers,dc=subdomain,dc=domain,dc=internal" read
    by self read
    by * none

access to *
    by * none
```

### Restart services

```bash
sudo systemctl restart slapd
sudo systemctl status slapd
```

### LDAP-Account-Manager (lam)

```bash
sudo wget https://github.com/LDAPAccountManager/lam/releases/download/8.9/ldap-account-manager_8.9-1_all.deb
sudo dpkg -i ldap-account-manager*.deb
sudo apt-get -f install
sudo dpkg -i ldap-account-manager*.deb
sudo apt install ldap-utils -y
```

```bash
sudo nano /etc/apache2/sites-available/lam.conf
```

```
<VirtualHost *:80>
	ServerAdmin [EMAIL]
	DocumentRoot /usr/share/ldap-account-manager
	ServerName [URL]

	<Directory /usr/share/ldap-account-manager/>
		Options FollowSymLinks
		AllowOverride All
        #Require all granted
        Require ip 127.0.0.1 xxx.xxx.xxx.0/24
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```bash
sudo a2ensite lam.conf
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo apachectl configtest
sudo systemctl restart apache2
sudo systemctl status apache2
```

```bash
sudo ufw allow http
sudo ufw allow https
```

> **Note:**
> http://[IPADDRESS]/lam

#### LAM configuration

> **Note:**
> password: lam

```
└── LAM Configuration
    ├── Edit general settings
    |   ├── Configuration storage
    |   ├── Security settings
    |   ├── Password policy
    |   ├── Logging
    |   └── Change master password *[PASSWORD]
    ├── Edit server profiles
    |   ├── General settings
    |   |   ├── Server settings
    |   |   |   ├── Server address *[URL]
    |   |   |   └── List of valid users * cn=admin,dc=subdomain,dc=domain,dc=internal
    |   |   ├── Language settings
    |   |   |   ├── Default language *
    |   |   |   └── Time zone *
    |   |   ├── Tool settings
    |   |   |   ├── Hidden tools
    |   |   |   |   ├── PDF editor *
    |   |   |   |   ├── Schema browser *
    |   |   |   |   ├── OU editor *
    |   |   |   |   ├── Tree view *
    |   |   |   |   ├── File upload *
    |   |   |   |   └── Tests *
    |   |   |   └── Tree view * dc=subdomain,dc=domain,dc=internal
    |   |   ├── Lamdaemon settings
    |   |   ├── Security settings
    |   |   ├── Global password policy override
    |   |   ├── 2-factor authentication
    |   |   └── Profile password *[PASSWORD]
    |   ├── Account types
    |   |   ├── Available account types
    |   |   |   └── Users +
    |   |   └── Active account types
    |   |       ├── USERS
    |   |       |   ├── LDAP suffix * ou=users,dc=subdomain,dc=domain,dc=internal
    |   |       |   ├── List attributes * #uidNumber;#uid;#givenName;#sn;#gidNumber
    |   |       |   └── Custom label * USERS
    |   |       ├── GROUPS
    |   |       |   ├── LDAP suffix * ou=groups,dc=subdomain,dc=domain,dc=internal
    |   |       |   ├── List attributes * #gidNumber;#cn;#memberUID;#description
    |   |       |   └── Custom label * GROUPS
    |   |       └── BINDUSERS
    |   |           ├── LDAP suffix * ou=bindusers,dc=subdomain,dc=domain,dc=internal
    |   |           ├── List attributes * #uidNumber;#uid
    |   |           └── Custom label * BINDUSERS
    |   ├── Modules
    |   |   ├── USERS
    |   |   |   └── Selected modules
    |   |   |       ├── * Personal (inetOrgPerson)
    |   |   |       ├── * Unix (posixAccount)
    |   |   |       └── * Shadow (shadowAccount)
    |   |   ├── GROUPS
    |   |   |   └── Selected modules
    |   |   |       └── * Unix (posixGroup)
    |   |   └── BINDUSERS
    |   |   |   └── Selected modules
    |   |   |       └── * Account (account)
    |   └── Module settings
    |       ├── Personal
    |       |   ├── Hidden options
    |       |   |   ├── Street *
    |       |   |   ├── Post office box *
    |       |   |   ├── Postal code *
    |       |   |   ├── Location *
    |       |   |   ├── State *
    |       |   |   ├── Postal address *
    |       |   |   ├── Registered address *
    |       |   |   ├── Office name *
    |       |   |   ├── Room number *
    |       |   |   ├── Telephone number *
    |       |   |   ├── Home telephone number *
    |       |   |   ├── Mobile number *
    |       |   |   ├── Fax number *
    |       |   |   ├── Pager *
    |       |   |   ├── Job title *
    |       |   |   ├── Car license *
    |       |   |   ├── Employee type *
    |       |   |   ├── Business category *
    |       |   |   ├── Department *
    |       |   |   ├── Manager *
    |       |   |   ├── Organisational unit *
    |       |   |   ├── Organisation *
    |       |   |   ├── Employee number *
    |       |   |   ├── Initials *
    |       |   |   ├── Web site *
    |       |   |   ├── User certificates *
    |       |   |   ├── Photo *
    |       |   |   └── Display name *
    |       ├── Unix
    |       |   ├── Users
    |       |   └── Options
    |       └── Unix
    |           └── Groups
    └── Import and export configuration
```

## Installation & (Dynamic)-Configuration (Standalone)

```bash
sudo apt install slapd
sudo systemctl status slapd
sudo slapd -V
```

```bash
sudo ufw allow ldap
sudo ufw allow ldaps
```

```bash
sudo dpkg-reconfigure slapd
```

```
no
subdomain.domain.internal
subdomain.domain.internal
no
yes
```

```bash
sudo nano /etc/ldap/ldap.conf
```

```
BASE    dc=subdomain,dc=domain,dc=internal
URI     ldap://ldap.subdomain.domain.internal ldaps://ldap.subdomain.domain.internal
```

```bash
sudo slapcat
```

### Restart services

```bash
sudo systemctl restart slapd
sudo systemctl status slapd
```

### Download Additional schema

#### Import Schema for SAMBA (method 1)

```bash
cd /etc/ldap/schema
sudo wget https://github.com/mwaeckerlin/openldap/raw/refs/heads/master/samba.schema
```

```bash
sudo nano /tmp/addschema.conf
```

```
include /etc/ldap/schema/core.schema
include /etc/ldap/schema/cosine.schema
include /etc/ldap/schema/nis.schema
include /etc/ldap/schema/inetorgperson.schema
include /etc/ldap/schema/samba.schema
include /etc/ldap/schema/misc.schema
```

```bash
sudo mkdir /tmp/slapd.d
sudo slaptest -f /tmp/addschema.conf -F /tmp/slapd.d
sudo cp "/tmp/slapd.d/cn=config/cn=schema/cn={4}samba.ldif" "/etc/ldap/slapd.d/cn=config/cn=schema"
sudo chown openldap: '/etc/ldap/slapd.d/cn=config/cn=schema/cn={4}samba.ldif'
sudo systemctl restart slapd
sudo systemctl status slapd
```

#### Import Schema for SAMBA (method 2)

```bash
cd /etc/ldap/schema
sudo wget https://github.com/mwaeckerlin/openldap/raw/refs/heads/master/samba.schema
```

```bash
sudo nano /etc/ldap/slapd.conf
```

```
include         /etc/ldap/schema/core.schema
include         /etc/ldap/schema/cosine.schema
include         /etc/ldap/schema/nis.schema
include         /etc/ldap/schema/inetorgperson.schema
include         /etc/ldap/schema/samba.schema
include         /etc/ldap/schema/misc.schema
```

```bash
sudo slaptest -f /etc/ldap/slapd.conf -v
```

```bash
cd /etc/ldap/schema
sudo wget https://raw.githubusercontent.com/zentyal/samba/refs/heads/master/examples/LDAP/samba.ldif
sudo ldapadd -x -D "cn=admin,dc=subdomain,dc=domain,dc=local" -W -H ldapi:/// -f samba.ldif
```

```bash
sudo systemctl restart slapd
sudo systemctl status slapd
```

#### Check if Schema is imported

```bash
sudo ldapsearch -LLLQY EXTERNAL -H ldapi:/// -b cn=schema,cn=config "(objectClass=olcSchemaConfig)" dn
```

### LDAP-Account-Manager (lam)

```bash
sudo wget https://github.com/LDAPAccountManager/lam/releases/download/8.9/ldap-account-manager_8.9-1_all.deb
sudo dpkg -i ldap-account-manager_8.9-1_all.deb
sudo apt-get -f install
sudo dpkg -i ldap-account-manager_8.9-1_all.deb
sudo apt install ldap-utils -y
```

```bash
sudo nano /etc/apache2/sites-available/lam.conf
```

```
<VirtualHost *:80>
	ServerAdmin [EMAIL]
	DocumentRoot /usr/share/ldap-account-manager
	ServerName [URL]

	<Directory /usr/share/ldap-account-manager/>
		Options FollowSymLinks
		AllowOverride All
        #Require all granted
        Require ip 127.0.0.1 xxx.xxx.xxx.0/24
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```bash
sudo a2ensite lam.conf
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo apachectl configtest
sudo systemctl restart apache2
sudo systemctl status apache2
```

```bash
sudo ufw allow http
sudo ufw allow https
```

> **Note:**
> http://[IPADDRESS]/lam

#### LAM configuration (with SAMBA)

> **Note:**
> password: lam

```
└── LAM Configuration
    ├── Edit general settings
    |   ├── Configuration storage
    |   ├── Security settings
    |   ├── Password policy
    |   ├── Logging
    |   └── Change master password *[PASSWORD]
    ├── Edit server profiles
    |   ├── General settings
    |   |   ├── Server settings
    |   |   |   ├── Server address *[URL]
    |   |   |   └── List of valid users * cn=admin,dc=subdomain,dc=domain,dc=internal
    |   |   ├── Language settings
    |   |   |   ├── Default language *
    |   |   |   └── Time zone *
    |   |   ├── Tool settings
    |   |   |   ├── Hidden tools
    |   |   |   |   ├── PDF editor *
    |   |   |   |   ├── Schema browser *
    |   |   |   |   ├── OU editor *
    |   |   |   |   ├── Tree view *
    |   |   |   |   ├── File upload *
    |   |   |   |   └── Tests *
    |   |   |   └── Tree view * dc=subdomain,dc=domain,dc=internal
    |   |   ├── Lamdaemon settings
    |   |   ├── Security settings
    |   |   ├── Global password policy override
    |   |   ├── 2-factor authentication
    |   |   └── Profile password *[PASSWORD]
    |   ├── Account types
    |   |   ├── Available account types
    |   |   |   └── Samba domains +
    |   |   └── Active account types
    |   |       ├── USERS
    |   |       |   ├── LDAP suffix * ou=users,dc=subdomain,dc=domain,dc=internal
    |   |       |   ├── List attributes * #uidNumber;#uid;#givenName;#sn;#gidNumber
    |   |       |   └── Custom label * USERS
    |   |       ├── GROUPS
    |   |       |   ├── LDAP suffix * ou=groups,dc=subdomain,dc=domain,dc=internal
    |   |       |   ├── List attributes * #gidNumber;#cn;#memberUID;#description
    |   |       |   └── Custom label * GROUPS
    |   |       └── SAMBA DOMAINS
    |   |           ├── LDAP suffix * dc=subdomain,dc=domain,dc=internal
    |   |       |   ├── List attributes * #sambaDomainName;#sambaSID
    |   |           └── Custom label * SAMBADOMAIN
    |   ├── Modules
    |   |   ├── USERS
    |   |   |   └── Selected modules
    |   |   |       ├── * Personal (inetOrgPerson)
    |   |   |       ├── * Unix (posixAccount)
    |   |   |       ├── * Shadow (shadowAccount)
    |   |   |       └── * Samba 3 (sambaSamAccount)
    |   |   ├── GROUPS
    |   |   |   └── Selected modules
    |   |   |       ├── * Unix (posixGroup)
    |   |   |       └── * Samba 3 (sambaGroupMapping)
    |   |   └── SAMBADOMAIN
    |   |   |   └── Selected modules
    |   |   |       └── * Samba Domain (sambaDomain)
    |   └── Module settings
    |       ├── Personal
    |       |   ├── Hidden options
    |       |   |   ├── Street *
    |       |   |   ├── Post office box *
    |       |   |   ├── Postal code *
    |       |   |   ├── Location *
    |       |   |   ├── State *
    |       |   |   ├── Postal address *
    |       |   |   ├── Registered address *
    |       |   |   ├── Office name *
    |       |   |   ├── Room number *
    |       |   |   ├── Telephone number *
    |       |   |   ├── Home telephone number *
    |       |   |   ├── Mobile number *
    |       |   |   ├── Fax number *
    |       |   |   ├── Pager *
    |       |   |   ├── Job title *
    |       |   |   ├── Car license *
    |       |   |   ├── Employee type *
    |       |   |   ├── Business category *
    |       |   |   ├── Department *
    |       |   |   ├── Manager *
    |       |   |   ├── Organisational unit *
    |       |   |   ├── Organisation *
    |       |   |   ├── Employee number *
    |       |   |   ├── Initials *
    |       |   |   ├── Web site *
    |       |   |   ├── User certificates *
    |       |   |   ├── Photo *
    |       |   |   └── Display name *
    |       ├── Unix
    |       |   ├── Users
    |       |   └── Options
    |       └── Unix
    |           └── Groups
    └── Import and export configuration
```

## LDAP - Search

```
# Show All
ldapsearch -x -H "ldap://ldap.subdomain.domain.internal" -b "dc=subdomain,dc=domain,dc=internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]

# Show Groups
ldapsearch -x -H "ldap://ldap.subdomain.domain.internal" -b "ou=groups,dc=subdomain,dc=domain,dc=internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]

# Show Groups Members

# Show Users
ldapsearch -x -H "ldap://ldap.subdomain.domain.internal" -b "ou=users,dc=subdomain,dc=domain,dc=internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]

# User Verify
ldapsearch -x -H "ldap://ldap.subdomain.domain.internal" -b "dc=subdomain,dc=domain,dc=internal" -D "uid=mustermann,ou=users,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]
```

## LDAPS - Encryption

```bash
sudo nano /etc/ldap/ldapkey.pem
sudo nano /etc/ldap/ldapcert.pem
sudo chown openldap /etc/ldap/ldapkey.pem
sudo chmod 600 /etc/ldap/ldapkey.pem
```

```bash
sudo nano /etc/ldap/slapd.conf
```

```
##### SSL #####
TLSCertificateFile /etc/ldap/ldapcert.pem
TLSCertificateKeyFile /etc/ldap/ldapkey.pem
```

```bash
sudo nano /etc/default/slapd
```

```
SLAPD_SERVICES="ldapi:/// ldaps:///"
```

```bash
sudo systemctl restart slapd
sudo ss -tlpn
```

[^1]: https://ldapwiki.com/wiki/Wiki.jsp?page=Best%20Practices%20for%20LDAP%20Security
[^2]: https://www.openldap.org/doc/admin24/slapdconfig.html
[^3]: https://bm-uni.de/einleitung.html
[^4]: https://www.youtube.com/watch?v=7Y0pHUZ7M6Q&list=PL9_MmqrG9KX7SyL7yOB_RDEvQo1k_nL46
[^5]: https://dokuwiki.nausch.org/doku.php/centos:ldap:ldaps
[^6]: https://computingforgeeks.com/install-and-configure-openldap-server-ubuntu/
[^7]: https://computingforgeeks.com/secure-ldap-server-with-ssl-tls-on-ubuntu/
[^8]: https://computingforgeeks.com/install-and-configure-ldap-account-manager-on-ubuntu/
[^9]: https://www.baeldung.com/linux/ldap-command-line-authentication
[^10]: https://gist.github.com/xzhangxa/561337f99a4b2dbd8e23
