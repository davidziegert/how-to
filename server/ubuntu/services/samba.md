# SAMBA (Ubuntu) [^1] [^2] [^3] [^4] [^5] [^6] [^7] [^8] [^9]

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
sudo hostnamectl set-hostname samba
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
127.0.1.1	samba
[IPADDRESS]	samba samba.subdomain.domain.internal
```

```bash
sudo hostnamectl
```

### Shared Folders

```bash
sudo mkdir -p /srv/samba/shares
sudo chown root:root /srv/samba/shares/
sudo chmod -R 0770 /srv/samba/shares/
```

## Installation (Standalone)

```bash
sudo apt install samba samba-common samba-common-bin samba-vfs-modules smbclient
```

```bash
sudo whereis samba
sudo samba -V
sudo systemctl status smbd nmbd
```

```bash
sudo ufw allow samba
```

### Customize Configuration in smb.conf (File-Sharing)

```bash
sudo nano /etc/samba/smb.conf
```

```
[global]
dns proxy = no
log file = /var/log/samba/log.%m
logging = file
map to guest = never
max log size = 10000
min protocol = SMB3
obey pam restrictions = Yes
pam password change = Yes
panic action = /usr/share/samba/panic-action %d
passwd chat = _Enter\snew\s_\spassword:* %n\n *Retype\snew\s*\spassword:* %n>
passwd program = /usr/bin/passwd %u
server role = standalone server
server string = %h server (Samba, Ubuntu)
unix password sync = Yes
usershare allow guests = no
workgroup = SUBDOMAIN
# hosts allow = xxx.xxx.xxx. xxx.xxx.xxx. localhost

[homes]
browseable = no
comment = Home Directories
create mask = 0700
directory mask = 0700
force create mode = 0700
force directory mode = 0700
read only = no
valid users = %S

[shares]
browseable = Yes
comment = Shared Folder
create mask = 2770
directory mask = 2770
force create mode = 2770
force directory mode = 2770
path = /srv/samba/shares
read only = no
valid users = @users

[nobody]
browseable = no
```

### Verify SMB Configuration

```bash
sudo testparm
sudo systemctl restart smbd nmbd
sudo systemctl status smbd nmbd
```

### Create user account (File-Sharing)

```bash
sudo adduser [USER]
sudo smbpasswd -a [USER]
```

### Verify SMB Shared Folders

```bash
sudo smbclient -L localhost -U%
```

### Verify SMB Authentification

```bash
sudo smbclient //localhost/shares -U [USER] -c 'ls'
```

### Listing all connections to the server

```bash
sudo smbstatus
```

## Installation (with openLDAP)

```bash
sudo apt install nslcd nscd libpam-ldapd libnss-ldapd ldap-utils smbldap-tools
```

```
ldap://xxx.xxx.xxx.xxx
dc=subdomain,dc=domain,dc=internal
[*] passwd
[*] group
[*] shadow
[ ] hosts
[ ] networks
[ ] ethers
[ ] protocols
[ ] services
[ ] netgroup
[ ] aliases
```

```bash
sudo ufw allow ldap
sudo ufw allow ldaps
```

### Check Authentification

```bash
sudo nano /etc/nsswitch.conf
```

```
passwd:         files systemd ldap
group:          files systemd ldap
shadow:         files systemd ldap
gshadow:        files systemd

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
```

```bash
sudo nano /etc/pam.d/common-password
```

```
password        [success=2 default=ignore]      pam_unix.so obscure yescrypt
password        [success=1 default=ignore]      pam_ldap.so use_authtok try_first_pass
password        requisite                       pam_deny.so
password        required                        pam_permit.so
```

### Test connection to openLDAP

```bash
ldapsearch -x -H "ldap://ldap.subdomain.domain.internal" -b "dc=subdomain,dc=domain,dc=internal" -D "cn=admin,dc=subdomain,dc=domain,dc=internal" -w [PASSWORD]
```

### Get local domain SID

```bash
sudo net getlocalsid
```

### Customize Configuration in smb.conf (File-Sharing)

```bash
sudo nano /etc/samba/smb.conf
```

```
[global]
dns proxy = no
log file = /var/log/samba/log.%m
logging = file
map to guest = never
max log size = 10000
min protocol = SMB3
netbios name = %h
obey pam restrictions = Yes
pam password change = Yes
panic action = /usr/share/samba/panic-action %d
passwd chat = _Enter\snew\s_\spassword:* %n\n *Retype\snew\s*\spassword:* %n>
passwd program = /usr/bin/passwd %u
server role = standalone server
server string = %h server (Samba, Ubuntu)
unix password sync = Yes
usershare allow guests = no
workgroup = SUBDOMAIN
# hosts allow = xxx.xxx.xxx. xxx.xxx.xxx. localhost

##### SMB-LDAP #####

# tls enabled  = Yes
# tls keyfile  = tls/key.pem
# tls certfile = tls/cert.pem
# tls cafile   = tls/ca.pem
# passdb backend = ldapsam:ldaps://xxx.xxx.xxx.xxx
# ldap ssl = On

tls enabled  = no
passdb backend = ldapsam:ldap://xxx.xxx.xxx.xxx
ldap ssl = off

ldap suffix = dc=subdomain,dc=domain,dc=internal
ldap admin dn = cn=admin,dc=subdomain,dc=domain,dc=internal
ldap user suffix = ou=users
ldap group suffix = ou=groups
ldap machine suffix = ou=computers
ldap idmap suffix = ou=Idmap
ldap passwd sync = Yes

#idmap config _ : backend = tdb
#idmap config _ : range = 500-10000
#idmap_ldb:use rfc2307 = Yes

add user script = /usr/sbin/smbldap-useradd -m '%u'
delete user script = /usr/sbin/smbldap-userdel %u
add group script = /usr/sbin/smbldap-groupadd -p '%g'
delete group script = /usr/sbin/smbldap-groupdel '%g'
add user to group script = /usr/sbin/smbldap-groupmod -m '%u' '%g'
delete user from group script = /usr/sbin/smbldap-groupmod -x '%u' '%g'
set primary group script = /usr/sbin/smbldap-usermod -g '%g' '%u'
add machine script = /usr/sbin/smbldap-useradd -w '%u'

logon script = %U.logon.bat
logon drive = H:
```

```bash
sudo smbldap-config
```

```
SID for domain SUBDOMAIN [] > S-1-5-21-1829660805-893160319-934263697
```

```bash
sudo nano /etc/smbldap-tools/smbldap.conf
sudo nano /etc/smbldap-tools/smbldap_bind.conf
```

```bash
sudo smbpasswd -w [PASSWORD]
sudo smbldap-populate
```

### Accounts

```
To list all users:

sudo smbldap-userlist
```

```
To list Samba domain groups:

sudo samba-tool group list
```

```
If you want to see member users from a Group:

sudo samba-tool group listmembers "Domain Admins"
```

```
To add a new user:

sudo smbldap-useradd -a -P [USERNAME]

The -a option adds the Samba attributes, and the -P option calls the smbldap-passwd utility after the user is created allowing you to enter a password for the user.
```

```
To remove a user:

sudo smbldap-userdel [USERNAME]

In the above command, use the -r option to remove the user's home directory.
```

```
To add a group:

sudo smbldap-groupadd -a [GROUPNAME]

As for smbldap-useradd, the -a adds the Samba attributes.
```

```
To make an existing user a member of a group:

sudo smbldap-groupmod -m [USERNAME] [GROUPNAME]

The -m option can add more than one user at a time by listing them in comma-separated format.
```

```
To remove a user from a group:

sudo smbldap-groupmod -x [USERNAME] [GROUPNAME]
```

```
To add a Samba machine account:

sudo smbldap-useradd -t 0 -w [USERNAME]

Replace username with the name of the workstation. The -t 0 option creates the machine account without a delay, while the -w option specifies the user as a machine account. Also, note the add machine script parameter in /etc/samba/smb.conf was changed to use smbldap-useradd.
```

### Bash-Scripts

#### Create Accounts

```
sudo nano create_LDAP_account.sh
```

```
#!/bin/bash

echo "First name:"
read vname
echo "Last name:"
read nname
echo "Email:"
read email
echo "Username:"
read uname

echo "An LDAP/Unix/Samba account is created, which automatically creates the home directory"

smbldap-useradd -N "$vname" -S "$nname" -M "$email" -amP "$uname"

# Passwort does not expire
pdbedit -u "$uname" -c "[X]"

echo "Account created successfully"
```

#### Create Groups

```
sudo nano create_LDAP_group.sh
```

```
#!/bin/bash

echo "Groupname:"
read grpname

echo "Group will be created"
sudo smbldap-groupadd -a "$grpname"
echo "Group created successfully"
```

## Installation LDAP-Login (Server/Client) (with SAMBA)

```bash
sudo apt -y install libnss-ldap libpam-ldap ldap-utils nscd
```

```
ldap://xxx.xxx.xxx.xxx
dc=subdomain,dc=domain,dc=internal
3
NO
NO
```

### Check Authentification (Server)

```bash
sudo nano /etc/nsswitch.conf
```

```
passwd:         files systemd ldap
group:          files systemd ldap
shadow:         files systemd ldap
gshadow:        files systemd

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
```

```bash
sudo nano /etc/pam.d/common-password
```

```
password        [success=2 default=ignore]      pam_unix.so obscure yescrypt
password        [success=1 default=ignore]      pam_ldap.so use_authtok try_first_pass
password        requisite                       pam_deny.so
password        required                        pam_permit.so
```

### Check Authentification (Client)

```bash
sudo nano /etc/nsswitch.conf
```

```
passwd:         files ldap
group:          files ldap
shadow:         files ldap
gshadow:        files

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
```

```bash
sudo nano /etc/pam.d/common-password
```

```
password        [success=2 default=ignore]      pam_unix.so obscure yescrypt
password        [success=1 default=ignore]      pam_ldap.so use_authtok try_first_pass
password        requisite                       pam_deny.so
password        required                        pam_permit.so
```

### Shared Folders access to [GROUPNAME]

```bash
sudo chown root:[GROUPNAME] /srv/samba/shares/
```

[^1]: https://computingforgeeks.com/install-and-configure-samba-server-share-on-ubuntu/
[^2]: https://github.com/conankiz/Ubuntu-20.04/blob/main/AD/Create%20an%20Active%20Directory%20Infrastructure%20with%20Samba4%20on%20Ubuntu.md
[^3]: https://github.com/nodiscc/xsrv/tree/master/roles/samba
[^4]: https://linuxconfig.org/how-to-configure-samba-server-share-on-ubuntu-20-04-focal-fossa-linux
[^5]: https://phoenixnap.com/kb/ubuntu-samba
[^6]: https://wiki.samba.org/index.php/Samba_Security_Documentation
[^7]: https://wiki.samba.org/index.php/Setting_up_Samba_as_a_Standalone_Server
[^8]: https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller
[^9]: https://www.techgrube.de/tutorials/ordnerfreigaben-ubuntu-20-04-homeserver-nas-teil-4
[^10]: https://leo.leung.xyz/wiki/Samba
