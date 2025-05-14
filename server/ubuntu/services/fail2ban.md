# fail2ban [^1] [^2] [^3] [^4] [^5]

## Installation

```bash
sudo apt install fail2ban -y
```

## Configuration

```bash
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

```
[INCLUDES]
before = paths-debian.conf

[DEFAULT]
ignoreip = 127.0.0.1/8 ::1 xxx.xxx.xxx.0/24                     # IGNORELIST
maxretry = 3                                                    # NUMBER OF FAILED ATTEMPTS
findtime = 10m                                                  # TIMESPAN BETWEEN FAILED ATTEMPTS
bantime  = 1h                                                   # BANTIME
banaction = ufw                                                 # JAIL VIA UFW
backend = polling                                               # POLLING ALGORITHM (NO EXTERNAL LIBRARIES)
logencoding = auto                                              # USE SYSTEM LOCAL ENCODING (UTF-8)
enabled = true                                                  # ENABLE JAILS

[sshd]
enabled = true
port = ssh
filter	= sshd
logpath	= /var/log/auth.log
maxretry = 3
findtime = 1h
bantime  = 1d
banaction = ufw
backend = polling
```

## Commands

```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl status fail2ban
```

```bash
sudo fail2ban-client ping
sudo fail2ban-client status
sudo fail2ban-client status sshd
```

```bash
sudo fail2ban-client get sshd bantime
sudo fail2ban-client get sshd maxretry
sudo fail2ban-client get sshd actions
sudo fail2ban-client get sshd findtime
sudo fail2ban-client get sshd ignoreip
```

```bash
sudo fail2ban-client set sshd banip IP-ADDRESS
sudo fail2ban-client set sshd unbanip IP-ADDRESS

sudo fail2ban-client set sshd addignoreip IP-ADDRESS
sudo fail2ban-client set sshd delignoreip IP-ADDRESS
```

## Reports

```bash
tail -100 /var/log/fail2ban.log.
```

or report via bash

```bash
sudo nano fail2banreport.sh
```

```
awk '($(NF-1) == "Ban"){print $NF}' /var/log/fail2ban.log \
  | sort | uniq -c | sort -n
```

[^1]: https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/
[^2]: https://www.linuxcapable.com/de/how-to-install-fail2ban-on-ubuntu-20-04-with-configuration/
[^3]: https://www.howtoforge.de/anleitung/so-installierst-und-konfigurierst-du-fail2ban-unter-ubuntu-22-04/
[^4]: https://www.booleanworld.com/protecting-ssh-fail2ban/
[^5]: https://www.the-art-of-web.com/system/fail2ban-log/
