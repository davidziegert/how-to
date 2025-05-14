# MySQL (Ubuntu) [^1] [^2] [^3]

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
```

## Installation

```bash
sudo apt install mysql-server
sudo mysql_secure_installation
```

```
Set root password?? [Y/n] y

There are three levels of password validation policy:
    LOW    Length >= 8
    MEDIUM Length >= 8, numeric, mixed case, and special characters
    STRONG Length >= 8, numeric, mixed case, special characters and dictionary file
Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:

Remove anonymous users? [Y/n] y
Disallow root login remotely? [Y/n] y
Remove test database and access to it? [Y/n] y
Reload privilege tables now? [Y/n] y
```

```bash
sudo nano /etc/mysql/my.cnf
```

```
# include *.cnf files, overwriting settings from here
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/

[client]
socket                           = /var/run/mysqld/mysqld.sock
port                             = 3306

[mysqld_safe]
socket                           = /var/run/mysqld/mysqld.sock
nice                             = 0

[mysqld]
user                             = mysql
socket                           = /var/run/mysqld/mysqld.sock
port                             = 3306
basedir                          = /usr
datadir                          = /var/lib/mysql
tmpdir                           = /tmp
lc-messages-dir                  = /usr/share/mysql
skip-external-locking
bind-address                     = 0.0.0.0
key_buffer_size                  = 256M
max_allowed_packet               = 1M
thread_stack                     = 192K
thread_cache_size                = 8
myisam-recover-options           = BACKUP
query_cache_limit                = 1M
query_cache_size                 = 16M
log_error                        = /var/log/mysql/error.log
expire_logs_days                 = 7
max_binlog_size                  = 100M
default_storage_engine           = InnoDB
character_set_server             = utf8
collation_server                 = utf8_general_ci

[mysqldump]
quick
max_allowed_packet               = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size                  = 128M
sort_buffer_size                 = 128M
read_buffer                      = 2M
write_buffer                     = 2M

[mysqlhotcopy]
interactive-timeout
```

```bash
sudo service mysql start
sudo service mysql stop
sudo systemctl status mysql
```

```bash
mysql -u root -p
```

## Database

```
SHOW DATABASES;
SHOW DATABASES LIKE pattern;

CREATE DATABASE [DATABASE];
DROP DATABASE [DATABASE];
```

## User

```
SELECT * FROM mysql.user;
```

```
CREATE USER '[USER]'@'%' IDENTIFIED BY '[PASSWORD]';
GRANT ALL PRIVILEGES ON *.* TO '[USER]' IDENTIFIED BY '[PASSWORD]';
FLUSH PRIVILEGES;
EXIT;
```

```
CREATE USER '[USER]'@'%' IDENTIFIED BY '[PASSWORD]';
GRANT ALL PRIVILEGES ON [DATABASE].* TO '[USER]' IDENTIFIED BY '[PASSWORD]';
FLUSH PRIVILEGES;
EXIT;
```

```
DROP USER '[USER]'@'%'
FLUSH PRIVILEGES;
EXIT;
```

### Grant Privileges to a User

```
ALL PRIVILEGES – Grants all privileges to a user account.
CREATE – The user account is allowed to create databases and tables.
DROP - The user account is allowed to drop databases and tables.
DELETE - The user account is allowed to delete rows from a specific table.
INSERT - The user account is allowed to insert rows into a specific table.
SELECT – The user account is allowed to read a database.
UPDATE - The user account is allowed to update table rows.
```

```
GRANT permission1, permission2 ON [DATABASE] TO 'user'@'%';
REVOKE permission1, permission2 ON [DATABASE].* FROM 'user'@'%';
SHOW GRANTS FOR 'user'@'%';
FLUSH PRIVILEGES;
EXIT;
```

```
GRANT ALL PRIVILEGES ON [DATABASE].* TO 'user'@'%';
REVOKE ALL PRIVILEGES ON [DATABASE].* FROM 'user'@'%';
SHOW GRANTS FOR 'user'@'%';
FLUSH PRIVILEGES;
EXIT;
```

## Backups [^4]

### Dumps

```bash
mysqldump -u username -p [DATABASE] > backup_name.sql
```

### Restore

```bash
mysql -u username -p mysql < backup_name.sql
```

### AutoBackup

```bash
sudo apt install automysqlbackup

sudo mkdir /var/lib/automysqlbackup
sudo nano /etc/default/automysqlbackup
```

```
# Host name (or IP address) of MySQL server e.g localhost
DBHOST=localhost

# List of databases for Daily/Weekly Backup
DBNAMES=`mysql --defaults-file=/etc/mysql/debian.cnf --execute="SHOW DATABASES" | awk '{print $1}' | grep -v ^Database$ | grep -v ^mysql$ | grep -v ^performance_schema$ | grep -v ^information_schema$ | tr \\\r\\\n ,\ `

# List of DBNAMES to EXLUCDE if DBNAMES are set to all (must be in " quotes)
DBEXCLUDE=""

# Backup directory location for root, with Unix rights 0600.
BACKUPDIR="/var/lib/automysqlbackup"

# Which day do you want weekly backups? (1 to 7 where 1 is Monday)
DOWEEKLY=1

# List of DBBNAMES for Monthly Backups.
MDBNAMES="mysql $DBNAMES"

# Include CREATE DATABASE in backup?
CREATE_DATABASE=yes

# Separate backup directory and file for each DB? (yes or no)
SEPDIR=yes

# Choose Compression type. (gzip or bzip2)
COMP=gzip

# Compress communications between backup server and MySQL server?
COMMCOMP=no

# Additionally keep a copy of the most recent backup in a seperate directory.
LATEST=no

#  The maximum size of the buffer for client/server communication. e.g. 16MB (maximum is 1GB)
MAX_ALLOWED_PACKET=

#  For connections to localhost. Sometimes the Unix socket file must be specified.
SOCKET=

# Backup of stored procedures and routines (comment to remove)
ROUTINES=yes
```

```bash
sudo automysqlbackup
```

#### Backup-Copy via rsync

```bash
sudo apt install rsync
sudo apt install sshpass
```

```bash
sudo nano /usr/local/bin/runmybackup.sh
sudo chown root:root /usr/local/bin/runmybackup.sh
sudo chmod 755 /usr/local/bin/runmybackup.sh
```

```
#!/bin/bash
sshpass -p '[PASSWORD]' rsync --ignore-existing -a /var/lib/automysqlbackup/ [USER]@[IPADDRESS]:/FOLDERNAME
```

```bash
crontab -e
```

```
0 0 * * * /usr/local/bin/runmybackup.sh
```

```bash
ssh-keyscan [IPADDRESS] >> ~/.ssh/known_hosts
```

[^1]: https://gridscale.io/community/tutorials/mysql-benutzer-rechte-zuweisen/
[^2]: https://linuxize.com/post/mysql-remote-access/
[^3]: https://www.a2hosting.com/kb/developer-corner/mysql/restricting-mysql-port-access#Method-1.3A-Disable-MySQL-networking
[^4]: https://hostadvice.com/how-to/how-to-backup-your-mysql-database-on-ubuntu-18-04-vps/
