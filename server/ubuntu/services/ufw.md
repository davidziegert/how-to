# UFW Firewall [^1] [^2]

## UFW Status

```bash
sudo ufw status
```

```bash
sudo ufw enable
sudo ufw disable
```

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

## Allow an IP Address

```bash
sudo ufw allow from xxx.xxx.xxx.xxx
sudo ufw allow from xxx.xxx.xxx.xxx to any port xxxx
```

## Allow a Subnet

```bash
sudo ufw allow from xxx.xxx.xxx.0/24
sudo ufw allow from xxx.xxx.xxx.0/24 to any port xxxx
```

## Block an IP Address

```bash
sudo ufw deny from xxx.xxx.xxx.xxx
sudo ufw deny from xxx.xxx.xxx.xxx to any port xxxx
```

## Block a Subnet

```bash
sudo ufw deny from xxx.xxx.xxx.0/24
sudo ufw deny from xxx.xxx.xxx.0/24 to any port xxxx
```

## List Available Applications

```bash
sudo ufw app list
```

## Enable/Disable Applications

```bash
sudo ufw allow ssh
sudo ufw deny ssh
```

## Enable/Disable Ports

```bash
sudo ufw allow 22
sudo ufw deny 22
```

## Enable/Disable Specific Port Ranges

```bash
sudo ufw allow 6000:6007/tcp
sudo ufw allow 6000:6007/udp
sudo ufw deny 6000:6007/tcp
sudo ufw deny 6000:6007/udp
```

## Logs [^10]

```bash
sudo ufw logging on
sudo ufw logging off
```

```bash
sudo nano /var/log/uwf.log
```

[^1]: https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
[^2]: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
