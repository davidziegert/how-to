# Linux - Service - Rsync (Ubuntu) [^1] [^2] [^3]

## Incremental Backups

```
sudo apt-get install rsync

sudo mkdir /var/scripts/
sudo chmod -R 755 /var/scripts/
sudo nano /var/scripts/backup.sh
```

```
#!/bin/bash
# A script to perform incremental backups using rsync

set -o errexit
set -o nounset
set -o pipefail

readonly SOURCE_DIR="/mnt/data"
readonly BACKUP_DIR="/mnt/backup"
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

mkdir -p "${BACKUP_DIR}"

rsync -av --delete \
    "${SOURCE_DIR}/" \
    --link-dest "${LATEST_LINK}" \
    --exclude=".cache" \
    "${BACKUP_PATH}"

rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
```

```
sudo systemctl enable cron
sudo crontab -e
```

```
# Minute (0-59) | Hour (0-23) | Day (1-31) | Month (1-12) | Day of the week  (0-7, Sundday is 0 or 7) |
# For example, a Cron time string of 0 10 15 * * executes a command on the 15th of each month at 10:00 A.M. UTC.

# every day at 1 am
0 1 * * * /var/scripts/backup.sh >>/var/log/cron.log 2>&1
```

## Transfer Files with Rsync over SSH [^4]

```
sudo rsync OPTION SourceDirectory_or_FilePath user@xxx.xxx.xxx.xxx:FolderName
sudo rsync -aP ~/SourceDirectory/ user@xxx.xxx.xxx.xxx:~/FolderName
```

## rsnapshot [^5]

```
sudo apt-get install rsnapshot
```

```
CAUTION: in rsnapshot.conf parameters and their values must be separated by a tab and no spaces.

sudo nano /etc/rsnapshot.conf
```

```
#################################################
# rsnapshot.conf - rsnapshot configuration file #
#################################################
# PLEASE BE AWARE OF THE FOLLOWING RULE:        #
# This file requires tabs between elements      #
#################################################
 
#######################
# CONFIG FILE VERSION #
#######################
 
config_version  1.2
 
#####################################################################################################
# SNAPSHOT ROOT DIRECTORY                                                                           #                                             
# All snapshots will be stored under this root directory.                                           #
# If no_create_root is enabled, rsnapshot will not automatically create the snapshot_root directory.#
#####################################################################################################

snapshot_root   /mnt/backup/
no_create_root  1

#########################################
# BACKUP INTERVALS                      #
# Must be unique and in ascending order #
# i.e. hourly, daily, weekly, etc.      #
#########################################

#retain     hourly  0
retain      daily   7
retain      weekly  4
retain      monthly 12

############################################
# GLOBAL OPTIONS                           #
# All are optional, with sensible defaults #
############################################

# Verbose level, 1 through 5.
# 1     Quiet           Print fatal errors only
# 2     Default         Print errors and warnings only
# 3     Verbose         Show equivalent shell commands being executed
# 4     Extra Verbose   Show extra verbose information
# 5     Debug mode      Everything

verbose     4
 
# Same as "verbose" above, but controls the amount of data sent to the
# logfile, if one is being used. The default is 3.
# If you want the rsync output, you have to set it to 4

loglevel    4
 
# If you enable this, data will be written to the file you specify. The
# amount of data written is controlled by the "loglevel" parameter.

logfile    /var/log/rsnapshot.log

#################
# EXCLUDE FILES #
#################

exclude_file   /data/nobackup

#################
# BACKUP POINTS #
#################
 
# LOCALHOST
backup  /home/
backup  /etc/ 
backup  /data/

########################################
# EXTERNAL PROGRAM DEPENDENCIES        #
# Enable remote ssh backups over rsync #
########################################

cmd_ssh /usr/bin/ssh
	
###############################
### BACKUP POINTS / SCRIPTS ###
###############################
 
backup  root@xxx.xxx.xxx.xxx:/data
```

```	
sudo rsnapshot configtest
```

```
sudo nano /etc/cron.d/rsnapshot
```

```
# cronjob must be equivalent to retain in rsnapshot.conf

# retain    hourly  0
# retain	daily   7
# retain	weekly  4
# retain	monthly 12

# every day at 01:00 AM | every monday at 03:00 AM | ever 1th of month at 05:00 AM 

# 0 0       * * *       root    /usr/bin/rsnapshot hourly
0 1         * * *       root    /usr/bin/rsnapshot daily
0 3         * * 1       root    /usr/bin/rsnapshot weekly
0 5         1 * *       root    /usr/bin/rsnapshot monthly

```

[^1]: https://linuxconfig.org/how-to-create-incremental-backups-using-rsync-on-linux
[^2]: https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
[^3]: https://crontab.guru/
[^4]: https://phoenixnap.com/kb/how-to-rsync-over-ssh
[^5]: https://wiki.ubuntuusers.de/rsnapshot/