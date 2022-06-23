# How To - Linux - Security (Ubuntu)

## Automatic Updates

```
sudo apt install unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

```
// Unattended-Upgrade::Mail "me@example.com ";
Unattended-Upgrade::Allowed-Origins
{
    "${distro_id} stable";"${distro_id} ${distro_codename}-security";
    "${distro_id} ${distro_codename}-updates";
    "${distro_id}ESMApps:${distro_codename}-apps-security";
    "${distro_id}ESM:${distro_codename}-infra-security";
};
Unattended-Upgrade::DevRelease "false";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "02:00";
```

```
sudo nano /etc/apt/apt.conf.d/20auto-upgrades
```

```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```

```
sudo unattended-upgrades --dry-run --debug
```

## Login via SSH Keys [^1]

### Server

```
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

### Client (Windows)

```
cd \Users\user
ssh-keygen -t rsa
type .ssh\id_rsa.pub | ssh user@xxx.xxx.xxx.xxx "cat >> .ssh/authorized_keys"
```

### Client (Mac/Linux)

```
ssh-keygen -t rsa
ssh-copy-id -i .ssh/id_rsa.pub user@xxx.xxx.xxx.xxx
ssh -i .ssh/id_rsa user@xxx.xxx.xxx.xxx
```

### Server

```
sudo nano /etc/ssh/sshd_config
```

```
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
```

```
sudo service ssh restart
```

## No Root Login

```
sudo nano /etc/ssh/sshd_config
```

```
PermitRootLogin no
```

```
sudo service ssh restart
```

## SSH Access to User or Group 

```
sudo nano /etc/ssh/sshd_config
```

```
AllowUsers user1 user2
AllowGroups root

DenyUsers user1 user2
DenyGroups group1
```

```
sudo service ssh restart
```

## Change SSH Port

```
sudo nano /etc/ssh/sshd_config
```

```
FROM: Port 22
TO: Port xxxxx
```

```
sudo service ssh restart
```

## UFW Firewall [^2] [^3]

### UFW Status
```
sudo ufw status
```

```
sudo ufw enable
sudo ufw disable
```

### Allow an IP Address

```
sudo ufw allow from xxx.xxx.xxx.xxx
```

### Block an IP Address

```
sudo ufw deny from xxx.xxx.xxx.xxx
```

### Block a Subnet

```
sudo ufw deny from xxx.xxx.xxx.0/24
```

### List Available Applications

```
sudo ufw app list
```

### Enable/Disable Applications

```
sudo ufw allow ssh
sudo ufw deny ssh
```

### Enable/Disable Ports

```
sudo ufw allow 22
sudo ufw deny 22
```

### Enable/Disable Specific Port Ranges

```
sudo ufw allow 6000:6007/tcp
sudo ufw allow 6000:6007/udp
sudo ufw deny 6000:6007/tcp
sudo ufw deny 6000:6007/udp
```

### Logs [^4]

```
sudo ufw logging on
sudo ufw logging off
```

```
sudo nano /var/log/uwf.log
```

## Fail2ban [^5] [^6]

```
sudo apt install fail2ban
```

```
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

```
[sshd]
enabled = true
maxretry = 3
findtime = 30m
bantime = 1d
ignoreip = 127.0.0.1/8 ::1 xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx
```

```
sudo systemctl restart fail2ban
sudo systemctl status fail2ban
```

```
sudo fail2ban-client set sshd banip xxx.xxx.xxx.xxx
sudo fail2ban-client set sshd unbanip xxx.xxx.xxx.xxx
```

```
sudo fail2ban-client status sshd
```

[^1]: https://kb.iu.edu/d/aews
[^2]: https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
[^3]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
[^4]: https://fedingo.com/how-to-check-ufw-log-status/
[^5]: https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/
[^6]: https://www.linuxcapable.com/de/how-to-install-fail2ban-on-ubuntu-20-04-with-configuration/