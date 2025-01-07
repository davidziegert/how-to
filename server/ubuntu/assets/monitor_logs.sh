#!/bin/bash

echo "#####################################"
echo "Authorization log"
echo "Location: /var/log/auth.log"
echo "---SSHD------------------------------"
# grep "sshd" /var/log/auth.log
# journalctl -t sshd
echo "---FAILED----------------------------"
# grep "Failed" /var/log/auth.log
echo "---INVALID---------------------------"
#grep "invalid" /var/log/auth.log
echo "---USER-NAMES------------------------"
grep "invalid" /var/log/auth.log | cut -d " " -f 11 | sort | uniq
echo "#####################################"

# Daemon Log
# Location: /var/log/daemon.log

# Debug log
# Location: /var/log/debug

# Kernel log
# Location: /var/log/kern.log

# Apache logs
# Location: /var/log/apache2/access.log
# Location: /var/log/apache2/error.log

# UFW log
# Location: /var/log/ufw.log

echo "#####################################"
echo "Fail2ban log"
echo "Location: /var/log/fail2ban.log"
grep "Ban" /var/log/fail2ban.log | grep -v "Restore" | cut -d " " -f 16 | sort | uniq
echo "#####################################"
