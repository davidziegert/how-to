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
include         /etc/ldap/schema/inetorgperson.schema
include         /etc/ldap/schema/nis.schema

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

### Restart services

```bash
systemctl restart slapd
systemctl status slapd
```

### Verify \*.conf

```bash
sudo slaptest -f /etc/ldap/slapd.conf -v
```
