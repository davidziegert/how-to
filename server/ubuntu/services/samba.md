# SAMBA (Ubuntu) [^1] [^2] [^3]

## Installation (with LDAP)

```bash
sudo apt install tasksel
sudo tasksel install samba-server
sudo apt install samba samba-common smbldap-tools ldapscripts smbclient slapd ldap-utils ldap-auth-client libnss-ldap libpam-ldap ldap-utils nscd
```

```
ldap://xxx.xxx.xxx.xxx:389
dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
3
no
no
```

## SAMBA-LDAP-Scheme (for LDAP)

```bash
sudo cp /usr/share/doc/samba/examples/LDAP/samba.ldif /etc/ldap/schema/
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/samba.ldif
sudo nano /etc/ldap/schema/samba_indices.ldif
```

```
dn: olcDatabase={1}hdb,cn=config
changetype: modify
add: olcDbIndex
olcDbIndex: uidNumber eq
olcDbIndex: gidNumber eq
olcDbIndex: loginShell eq
olcDbIndex: uid eq,pres,sub
olcDbIndex: memberUid eq,pres,sub
olcDbIndex: uniqueMember eq,pres
olcDbIndex: sambaSID eq
olcDbIndex: sambaPrimaryGroupSID eq
olcDbIndex: sambaGroupType eq
olcDbIndex: sambaSIDList eq
olcDbIndex: sambaDomainName eq
olcDbIndex: default sub
```

```bash
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/samba_indices.ldif
```

## Set Authentication (for LDAP)

```bash
sudo cp /usr/share/doc/smbldap-tools/examples/smbldap.conf.gz /etc/smbldap-tools/
sudo cp /usr/share/doc/smbldap-tools/examples/smbldap_bind.conf /etc/smbldap-tools/
sudo gzip -d /etc/smbldap-tools/smbldap.conf.gz
sudo pam-auth-update
    *
    *
    *
    *

    *
```

```bash
sudo nano /etc/nsswitch.conf
```

```
passwd: files ldap systemd
group: files ldap systemd
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
password [success=1 user_unknown=ignore default=die] pam_ldap.so use_authtok try_first_pass
password requisite pam_deny.so
password required pam_permit.so
```

## Samba Configuration [^4]

```bash
sudo net getlocalsid
```

```
# Example

S-1-5-21-2305295940-2782501175-1093577454
```

```bash
sudo nano /etc/samba/smb.conf
```

```
#======================= Global Settings =======================

[global]
workgroup = WORKGROUP
netbios name = NAME
server string = NAME
dns proxy = No
domain logons = Yes
domain master = Yes
local master = Yes
preferred master = Yes
wins support = Yes
os level = 200
obey pam restrictions = Yes
log file = /var/log/samba/log.%m
max log size = 1000
panic action = /usr/share/samba/panic-action %d
pam password change = Yes
unix password sync = No
hide dot files = Yes
hide files = /lost+found/desktop.ini/ntuser.ini/NTUSER.*/Thumbs.db/

mangled names = no
dos charset = CP850
unix charset = UTF-8
display charset = UTF-8

passdb backend = ldapsam:ldap://xxx.xxx.xxx.xxx
ldap suffix = dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
ldap admin dn = cn=admin,dc=SUBDOMAIN,dc=DOMAIN,dc=TLD
ldap user suffix = ou=users
ldap group suffix = ou=groups
ldap machine suffix = ou=computers
ldap idmap suffix = ou=idmap
ldap passwd sync = Yes
ldap ssl = No

unix extensions = yes
os level = 35
syslog = 0
idmap config * : backend = tdb

idmap config * : range = 1000000-1999999
logon drive = H:
logon home = \\%N\%U
logon path = \\%N\profiles\%U\%a
logon script = allusers.bat

#======================= Share Definitions =======================

[homes]

comment = Home Directories
valid users = %S
read only = No
browseable = No

[data]

comment = Data Directories
path = /GROUPNAME
valid users = @GROUPNAME
browseable = yes
writeable = yes
create mask = 2660
directory mask = 2770 
force user = shareuser
```

```bash
sudo smbpasswd -w 'PASSWORD'
sudo testparm
sudo smbldap-config
```

```
workgroup name>                                                 ENTER
netbios name>                                                   ENTER
logon drive>                                                    ENTER
logon home>                                                     ENTER
logon path>                                                     ENTER
home directory prefix>                                          ENTER
default users>                                                  ENTER
default user netlogon script>                                   ENTER
default password validation time>                               365
ldap suffix>                                                    ENTER
ldap group suffix>                                              ENTER
ldap user suffix>                                               ENTER
ldap machine suffix>                                            ENTER
Idmap suffix>                                                   ENTER
sambaUnixIdPooldn object>                                       ENTER
ldap master server>                                             ENTER
ldap master port>                                               ENTER
ldap master bind dn>                                            ENTER
ldap master bind password>                                      PASSWORD
ldap slave server>                                              ENTER
ldap slave port>                                                ENTER
ldap slave bind dn>                                             ENTER
ldap slave bind password>                                       PASSWORD
ldap tls support>                                               ENTER
SID for domain>                                                 ENTER
unix password encryption (CRYPT, MD5, SMD5, SSHA, SHA) [SSHA]>  ENTER
default user gidNumber [513]>                                   ENTER
default computer gidNumber [515]>                               ENTER
default login shell [/bin/bash]>                                ENTER
default skeleton directory [/etc/skel]>                         ENTER
default domain name to append to mail address []>               ENTER
```

### Check whether entries have been made in the following files:

```bash
sudo nano /etc/smbldap-tools/smbldap.conf
sudo nano /etc/smbldap-tools/smbldap_bind.conf
```

## Publish Samba

```bash
sudo smbldap-populate
sudo reboot now
```

## Commands

```bash
sudo service smbd start
sudo service smbd stop
sudo systemctl restart smb.service
sudo systemctl restart nmb.service
sudo smbstatus
```

### Accounts

```
Example ( smbldap-useradd -N "Susi" -S "Sorglos" -M "susi@test.de" -amP "susi.sorglos" )
```

```
To add a new user:

    sudo smbldap-useradd -a -P username

The -a option adds the Samba attributes, and the -P option calls the smbldap-passwd utility after the user is created allowing you to enter a password for the user.
```

```
To remove a user:

	sudo smbldap-userdel username

In the above command, use the -r option to remove the user's home directory.
```

```
To add a group:

	sudo smbldap-groupadd -a groupname

As for smbldap-useradd, the -a adds the Samba attributes.
```

```
To make an existing user a member of a group:

	sudo smbldap-groupmod -m username groupname

The -m option can add more than one user at a time by listing them in comma-separated format.
```

```
To remove a user from a group:

	sudo smbldap-groupmod -x username groupname
```

```
To add a Samba machine account:

	sudo smbldap-useradd -t 0 -w username

Replace username with the name of the workstation. The -t 0 option creates the machine account without a delay, while the -w option specifies the user as a machine account. Also, note the add machine script parameter in /etc/samba/smb.conf was changed to use smbldap-useradd.
```

### Bash-Scripts

#### Create Accounts

```
sudo nano create_LDAP_account.sh
```

```
#!/bin/bash

echo "Vorname:"
read vname
echo "Nachname:"
read nname
echo "email:"
read email
echo "username:"
read uname

echo "An LDAP/Unix/Samba account is created, which automatically creates the home directory"

smbldap-useradd -N "$vname" -S "$nname" -M "$email" -amP "$uname"

# Passwort does not expire
pdbedit -u "$uname" -c "[X]"

echo "SUCCESS"
```

#### Create Groups

```
sudo nano create_LDAP_group.sh
```

```
#!/bin/bash

echo "CREATE GROUPS"
sudo smbldap-groupadd -a GROUPNAME
echo "SUCCESS"
```

#### Create Folders

```
sudo nano create_FOLDER.sh
```

```
#!/bin/bash

echo "CREATE FOLDERS"
sudo mkdir /GROUPNAME/

echo "BESITZER SETZEN"
chown -R root:GRUPPENNAME /GRUPPENNAME

echo "RECHTE SETZEN"
chmod -R 770 /GRUPPENNAME	

echo "SUCCESS"
```

[^1]: https://kifarunix.com/install-and-configure-samba-file-server-on-ubuntu-20-04/
[^2]: https://linuxconfig.org/how-to-configure-samba-server-share-on-ubuntu-20-04-focal-fossa-linux
[^3]: https://computingforgeeks.com/install-and-configure-samba-server-share-on-ubuntu/
[^4]: https://www.techgrube.de/tutorials/ordnerfreigaben-ubuntu-20-04-homeserver-nas-teil-4