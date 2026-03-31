# Linux (Ubuntu)

## Applications

### MOTD

```bash
sudo apt install -y figlet
sudo cp /etc/update-motd.d/99-custom /etc/update-motd.d/99-custom.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/update-motd.d/99-custom
```

```
#!/bin/bash
printf "You're connected to: \n"
figlet "$(hostname -s)"
```

### Samba

```bash
sudo apt install -y samba sssd libnss-sss libpam-sss ldap-utils
```

```bash
sudo cp /etc/nsswitch.conf /etc/nsswitch.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/nsswitch.conf
```

```
# change to
passwd:         files systemd sss
group:          files systemd sss
shadow:         files sss
```

```bash
sudo pam-auth-update --enable mkhomedir || true
```

```bash
sudo cp /etc/sssd/sssd.conf /etc/sssd/sssd.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/sssd/sssd.conf
```

```
[sssd]
services = nss, pam
config_file_version = 2
domains = default

[domain/default]
id_provider = ldap
auth_provider = ldap
chpass_provider = ldap

ldap_uri = ldaps://ldap.example.com
ldap_search_base = dc=example,dc=com

ldap_default_bind_dn = cn=admin,dc=example,dc=com
ldap_default_authtok = NEW_PASSWORD

cache_credentials = True
enumerate = False

ldap_tls_ca_cert = /etc/ssl/ldap/ldap.crt
ldap_tls_reqcert = demand
```

```bash
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/samba/smb.conf
```

```
[global]
   workgroup = WORKGROUP
   security = user
   passdb backend = ldapsam
   obey pam restrictions = yes
   pam password change = yes
   unix password sync = yes
   map to guest = bad user

[homes]
   path = /home
   comment = Home Directories
   browsable = no
   read only = no
   create mask = 0700
   directory mask = 0700
   # Restrict access
   valid users = %S @users

[shared]
   path = /share
   comment = Shared Directories
   browsable = yes
   read only = no
   guest ok = no
   create mask = 0660
   directory mask = 0770
   # Restrict access
   valid users = @users
```

```bash
sudo chmod 600 /etc/sssd/sssd.conf
sudo mkdir -p /share
sudo chown root:users /share
sudo chmod 2770 /share
sudo systemctl enable smbd nmbd sssd
sudo systemctl restart smbd nmbd sssd
sudo getent passwd
sudo getent group
```

### LDAP

#### Server

```bash
sudo apt install -y slapd ldap-utils openssl
```

```bash
debconf-set-selections <<EOF
slapd slapd/no_configuration boolean false
slapd slapd/domain string example.com
slapd shared/organization string MY_ORAGNIZATION
slapd slapd/password1 password NEW_PASSWORD
slapd slapd/password2 password NEW_PASSWORD
slapd slapd/backend select MDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true
slapd slapd/allow_ldap_v2 boolean false
EOF
```

```bash
sudo dpkg-reconfigure -f noninteractive slapd
```

```bash
sudo systemctl enable slapd
sudo systemctl restart slapd
sudo systemctl status slapd
sudo mkdir -p /etc/ssl/ldap
sudo chmod 700 /etc/ssl/ldap
```

```bash
openssl req -x509 -nodes -days 3650 \
-newkey rsa:4096 \
-keyout /etc/ssl/ldap/ldap.key \
-out /etc/ssl/ldap/ldap.crt \
-subj "/C=MY_COUNTRY/ST=MY_COUNTY/L=MY_CITY/O=MY_ORAGNIZATION/CN=example.com"
```

```bash
sudo chown root:root /etc/ssl/ldap/ldap.key /etc/ssl/ldap/ldap.crt
sudo chmod 600 /etc/ssl/ldap/ldap.key
sudo chmod 644 /etc/ssl/ldap/ldap.crt
```

```bash
sudo nano /tmp/tls.ldif
```

```
dn: cn=config
changetype: modify
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ssl/ldap/ldap.crt
-
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ssl/ldap/ldap.key
```

```bash
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/tls.ldif
sed -i 's/^SLAPD_SERVICES=.*/SLAPD_SERVICES="ldap:\/\/\/ ldapi:\/\/\/ ldaps:\/\/\/"/' /etc/default/slapd
sudo systemctl restart slapd
sudo systemctl status slapd
sudo ufw allow ldaps
```

```bash
ldapsearch -x -H ldaps://localhost \
-b "dc=example,dc=com" \
-D "cn=admin, dc=example,dc=com" \
-w "NEW_PASSWORD"
```

#### Client

```bash
sudo apt install -y sssd libnss-sss libpam-sss ldap-utils
```

```bash
sudo cp /etc/nsswitch.conf /etc/nsswitch.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/nsswitch.conf
```

```
# change to
passwd:         files systemd sss
group:          files systemd sss
shadow:         files sss
```

```bash
sudo pam-auth-update --enable mkhomedir || true
```

```bash
sudo cp /etc/sssd/sssd.conf /etc/sssd/sssd.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/sssd/sssd.conf
```

```
[sssd]
services = nss, pam
config_file_version = 2
domains = default

[domain/default]
id_provider = ldap
auth_provider = ldap
chpass_provider = ldap

ldap_uri = ldaps://ldap.example.com
ldap_search_base = dc=example,dc=com

ldap_default_bind_dn = cn=admin,dc=example,dc=com
ldap_default_authtok = NEW_PASSWORD

cache_credentials = True
enumerate = False

# TLS
ldap_tls_ca_cert = /etc/ssl/ldap/ldap.crt
ldap_tls_reqcert = demand

# Optional:
ldap_id_use_start_tls = False
```

```bash
sudo chmod 600 /etc/sssd/sssd.conf
sudo systemctl enable sssd
sudo systemctl restart sssd
sudo scp root@ldap.example.com:/etc/ssl/ldap/ldap.crt /etc/ssl/ldap/ldap.crt
sudo chown root:root /etc/ssl/ldap/ldap.crt
sudo chmod 644 /etc/ssl/ldap/ldap.crt
sudo update-ca-certificates
sudo getent passwd
```

### NFS

#### Server

```bash
sudo apt install -y nfs-kernel-server
sudo chmod 755 /home
sudo mkdir -p /share
sudo chown nobody:sharegroup /share
sudo chmod 770 /share
```

```bash
sudo cp /etc/exports /etc/exports.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/exports
```

```
# <device>              <client>(options)
/home                   192.168.1.0/24(rw,sync,no_subtree_check,root_squash)
/share               192.168.1.0/24(rw,sync,no_subtree_check,root_squash)
```

```bash
sudo cp /etc/idmapd.conf /etc/idmapd.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/idmapd.conf
```

```
[General]
# Set this to your DNS/LDAP domain name
Domain = localdomain

[Mapping]
Nobody-User = nobody
Nobody-Group = nogroup

[Translation]
# Default translation method
Method = nsswitch
```

```bash
sudo exportfs -ra
sudo ufw allow from 192.168.1.0/24 to any port nfs
sudo systemctl enable nfs-kernel-server
sudo systemctl restart nfs-kernel-server
sudo systemctl status nfs-kernel-server
```

#### Client

```bash
sudo apt install -y nfs-common
sudo mkdir -p /share
```

```bash
sudo cp /etc/fstab /etc/fstab.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/fstab
```

```
# <device>                  <mount point>   <type>  <options>                               <dump>  <fsck>
192.168.1.1:home            /home           nfs     rw,sync,no_subtree_check,root_squash    0       0
192.168.1.1:share        /share       nfs     rw,sync,no_subtree_check,root_squash    0       0
```

```bash
sudo cp /etc/idmapd.conf /etc/idmapd.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/idmapd.conf
```

```
[General]
# Set this to your DNS/LDAP domain name
Domain = localdomain

[Mapping]
Nobody-User = nobody
Nobody-Group = nogroup

[Translation]
# Default translation method
Method = nsswitch
```

```bash
sudo cp /etc/pam.d/common-session /etc/pam.d/common-session.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/pam.d/common-session
```

```
# add end of file
session     required        pam_mkhomedir.so        skel=/etc/skel      umask=0007
```

```bash
sudo cp /etc/profile /etc/profile.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/profile
```

```
# add end of file
umask=0007
```

```bash
sudo cp /etc/login.defs /etc/login.defs.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/login.defs
```

```
# add end of file
umask=0007
```

```bash
sudo systemctl enable nfs-common
sudo systemctl restart nfs-common
sudo systemctl status nfs-common
sudo ufw allow from 192.168.1.1 to any port nfs
sudo df -h
```

### BIND9 DNS

```bash
sudo apt install -y bind9 bind9utils bind9-doc dnsutils
```

```bash
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/bind/named.conf.options
```

```
options {
    directory "/var/cache/bind";

    // Hide version (security hardening)
    version "not currently available";

    // Enable recursion (needed for internal clients)
    recursion yes;

    // Restrict recursion to trusted networks only
    allow-recursion {
        127.0.0.1;
        10.10.10.0/24;
        192.168.1.0/24;
    };

    // Allow queries from anywhere (authoritative zones)
    allow-query { any; };

    // Forward DNS queries to upstream resolvers
    forwarders {
        1.1.1.1;
        8.8.8.8;
    };

    // Enable DNSSEC validation
    dnssec-validation auto;

    // Listen on IPv4 and optionally IPv6
    listen-on { any; };
    listen-on-v6 { any; };

    // Prevent abuse
    allow-transfer { none; };

    // Logging
    querylog yes;

    // Additional hardening
    auth-nxdomain no;        # RFC compliance
    minimal-responses yes;
};
```

```bash
sudo cp /etc/bind/named.conf.local /etc/bind/named.conf.local.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/bind/named.conf.local
```

```
zone "example.com" {
    type master;
    file "/etc/bind/db.example.com";
    allow-query { any; };
};

zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.1.168.192.in-addr.arpa";
    allow-query { any; };
};
```

```bash
sudo nano /etc/bind/db.example.com
```

```
$TTL    86400
@       IN      SOA     dns.example.com.    admin.example.com.  (
                        2026010101          ; Serial
                        7200                ; Refresh
                        3600                ; Retry
                        604800              ; Expire
                        86400 )             ; Negative Cache TTL

                        IN      NS          dns.domain_zone.
dns.example.com.        IN      A           192.168.1.2

client_1                IN      A           192.168.1.1
```

```bash
sudo nano /etc/bind/db.1.168.192.in-addr.arpa
```

```
$TTL    86400
@       IN      SOA     dns.example.com.    admin.example.com.  (
                        2026010101          ; Serial
                        7200                ; Refresh
                        3600                ; Retry
                        604800              ; Expire
                        86400 )             ; Negative Cache TTL

                        IN      NS          dns.example.com.
dns.example.com.        IN      A           192.168.1.2

1                       IN      PTR         client_1.example.com.
```

```bash
sudo ufw allow Bind9
sudo named-checkconf
sudo named-checkzone example.com /etc/bind/db.example.com
sudo named-checkzone 1.168.192.in-addr.arpa /etc/bind/db.1.168.192.in-addr.arpa
sudo systemctl enable named
sudo systemctl restart named
sudo systemctl status named --no-pager
```

### Unbound DNS

```bash
sudo apt install -y unbound
```

```bash
wget -O /var/lib/unbound/root.hints https://www.internic.net/domain/named.cache
sudo chown unbound:unbound /var/lib/unbound/root.hints
```

```bash
sudo cp /etc/unbound/unbound.conf.d/resolver.conf /etc/unbound/unbound.conf.d/resolver.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/unbound/unbound.conf.d/resolver.conf
```

```
server:
    # Interfaces (restrict to localhost unless you need LAN access)
    interface: 127.0.0.1
    interface: ::1
    port: 53

    # Allow local network access
    access-control: 127.0.0.0/8 allow
    access-control: 10.0.0.0/8 allow
    access-control: 192.168.1.0/24 allow

    # Privacy hardening
    hide-identity: yes
    hide-version: yes
    qname-minimisation: yes
    minimal-responses: yes

    # DNSSEC
    auto-trust-anchor-file: "/var/lib/unbound/root.key"
    harden-dnssec-stripped: yes
    harden-algo-downgrade: yes

    # Additional hardening
    harden-glue: yes
    harden-referral-path: yes
    use-caps-for-id: yes

    # Cache tuning
    cache-min-ttl: 300
    cache-max-ttl: 86400
    prefetch: yes
    prefetch-key: yes

    # Performance
    num-threads: 2
    so-reuseport: yes
    msg-cache-size: 128m
    rrset-cache-size: 256m

    # Security limits
    unwanted-reply-threshold: 10000000
    do-not-query-localhost: no

    # Logging (disable in high-performance setups)
    verbosity: 1
    logfile: ""

    # Root hints
    root-hints: "/var/lib/unbound/root.hints"
```

```bash
sudo cp /etc/unbound/unbound.conf.d/local-zones.conf /etc/unbound/unbound.conf.d/local-zones.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/unbound/unbound.conf.d/local-zones.conf
```

```
local-zone: "example.com." static
    local-data: "client_1.example.com.     IN      A       192.168.1.1"
```

```bash
sudo unbound-checkconf
sudo systemctl is-enabled unbound
sudo systemctl status unbound
sudo systemctl restart unbound
sudo systemctl status unbound
sudo ufw allow 53
```

### ISC DHCP

```bash
sudo apt install -y isc-dhcp-server
```

```bash
sudo cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/dhcp/dhcpd.conf
```

```
# Global options
option domain-name "example.com";
option domain-name-servers 192.168.1.2;
option routers 192.168.1.254;
option subnet-mask 255.255.255.0;

# Default lease time (seconds)
default-lease-time 600;
max-lease-time 7200;

# DHCP server is authoritative for this network
authoritative;

# Log messages
log-facility local7;

subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.100 192.168.1.200;

    host client_001 {hardware ethernet 00:00:39:3E:E3:E2; fixed-address 192.168.1.100;}
}
```

```bash
sudo sed -i "s/^INTERFACESv4=.*/INTERFACESv4=\"enp1s0\"/" /etc/default/isc-dhcp-server
```

```bash
sudo ufw allow 67
sudo systemctl enable isc-dhcp-server.service
sudo systemctl restart isc-dhcp-server.service
sudo systemctl status isc-dhcp-server --no-pager
sudo dhcp-lease-list
```

### Kea DHCP

```bash
sudo apt install -y kea-dhcp4-server
```

```bash
sudo cp /etc/kea/kea-dhcp4.conf /etc/kea/kea-dhcp4.conf.$(date +%Y%m%d_%H%M%S).backup
sudo nano /etc/kea/kea-dhcp4.conf
```

```
{
    "Dhcp4": {
        "interfaces-config": {
            "interfaces": [ "enp1s0" ]
        },

        "lease-database": {
            "type": "memfile",
            "persist": true,
            "name": "/var/lib/kea/kea-leases4.csv"
        },

        "valid-lifetime": 86400,
        "renew-timer": 43200,
        "rebind-timer": 75600,

        "subnet4": [
            {
                "subnet": "192.168.1.0/255.255.255.0",
                "pools": [
                    {
                        "pool": "192.168.1.100 - 192.168.1.200"
                    }
                ],
                "option-data": [
                    {
                        "name": "routers",
                        "data": "192.168.1.254"
                    },
                    {
                        "name": "domain-name-servers",
                        "data": "192.168.1.2"
                    }
                ],
                "reservations": [
                    {
                        "hw-address": "00:00:39:3E:E3:E2",
                        "ip-address": "192.168.1.100"
                    }
                ]
            }
        ]
    }
}
```

```bash
sudo ufw allow 67
sudo systemctl enable kea-dhcp4-server
sudo systemctl restart kea-dhcp4-server
sudo systemctl status kea-dhcp4-server --no-pager
sudo dhcp-lease-list
```