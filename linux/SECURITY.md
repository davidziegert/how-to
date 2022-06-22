# How To - Linux - Security (Ubuntu)

## No Root-Login

```
sudo nano /etc/ssh/sshd_config
```

```
PermitRootLogin no
```

## UFW Firewall [^1] [^2]

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

### Logs [^3]

```
sudo ufw logging on
sudo ufw logging off
```

```
sudo nano /var/log/uwf.log
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

[^1]: https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
[^2]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
[^3]: https://fedingo.com/how-to-check-ufw-log-status/