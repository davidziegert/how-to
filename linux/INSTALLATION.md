# How To - Linux - Installation (Ubuntu)

## Updates

```
sudo apt-get update
sudo apt-get upgrade
```

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

## Cleanup

```
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove
```

## Set Time Zone

```
sudo timedatectl set-timezone Europe/Berlin
sudo timedatectl
```

## Set Time Synchronization

```
sudo timedatectl set-ntp on
```

```
sudo nano /etc/systemd/timesyncd.conf
```

```
[Time]
NTP=times.tubit.tu-berlin.de
FallbackNTP=ntp01.urz.uni-heidelberg.de
```

```
sudo systemctl restart systemd-timesyncd 
sudo systemctl status systemd-timesyncd
```

## Set Hostname

```
sudo hostnamectl set-hostname XXX
sudo nano /etc/cloud/cloud.cfg
```

```
FROM: preserve_hostname: false
TO: preserve_hostname: true
```

```
sudo nano /etc/hosts
```

```
127.0.0.1 localhost
127.0.1.1 xxx.xxx.xxx.xxx name.subdomain.sldomain.tldomain
```

```
sudo hostnamectl
```

## Set IP-Address

### Netplan (new) [^1]

```
sudo nano /etc/netplan/00-installer-config.yaml
```

#### Fixed IP

```
network:
    version: 2
    renderer: networkd
    ethernets:
        en01:
            addresses:
            - xxx.xxx.xxx.xxx/24
            - "2001:1::1/64"
            gateway4: xxx.xxx.xxx.xxx
            gateway6: "2001:1::2"
            nameservers:
                addresses:
                - 8.8.8.8
                - xxx.xxx.xxx.xxx
```

```
sudo netplan apply
```

#### DHCP

```
network:
    version: 2
    renderer: networkd
    ethernets:
        en01:
            dhcp4: true
            dhcp6: true
```

```
sudo netplan apply
```

### Network Interfaces (old) [^2]

```
sudo nano /etc/network/interfaces
```

#### Fixed IP

```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto en01
iface en01 inet static
    address xxx.xxx.xxx.xxx
    netmask 255.255.255.0
    network xxx.xxx.xxx.0
    broadcast xxx.xxx.xxx.255
    gateway xxx.xxx.xxx.xxx
    dns-nameservers xxx.xxx.xxx.xxx
    dns-search subdomain.domain.toplevel
```

```
sudo service networking restart
```

#### DHCP

```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
```

```
sudo service networking restart
```

## Change Password

```
sudo passwd USERNAME
```

## Message of the Day [^3] [^4]

```
sudo nano /etc/motd
```

```

.-----------------------------------------------------------------------------.
||Es| |F1 |F2 |F3 |F4 |F5 | |F6 |F7 |F8 |F9 |F10|                  C= AMIGA   |
||__| |___|___|___|___|___| |___|___|___|___|___|                             |
| _____________________________________________     ________    ___________   |
||~  |! |" |§ |$ |% |& |/ |( |) |= |? |` || |<-|   |Del|Help|  |{ |} |/ |* |  |
||`__|1_|2_|3_|4_|5_|6_|7_|8_|9_|0_|ß_|´_|\_|__|   |___|____|  |[ |]_|__|__|  |
||<-  |Q |W |E |R |T |Z |U |I |O |P |Ü |* |   ||               |7 |8 |9 |- |  |
||->__|__|__|__|__|__|__|__|__|__|__|__|+_|_  ||               |__|__|__|__|  |
||Ctr|oC|A |S |D |F |G |H |J |K |L |Ö |Ä |^ |<'|               |4 |5 |6 |+ |  |
||___|_L|__|__|__|__|__|__|__|__|__|__|__|#_|__|       __      |__|__|__|__|  |
||^    |> |Y |X |C |V |B |N |M |; |: |_ |^     |      |A |     |1 |2 |3 |E |  |
||_____|<_|__|__|__|__|__|__|__|,_|._|-_|______|    __||_|__   |__|__|__|n |  |
|   |Alt|A  |                       |A  |Alt|      |<-|| |->|  |0    |. |t |  |
|   |___|___|_______________________|___|___|      |__|V_|__|  |_____|__|e_|  |
|                                                                             |
`-----------------------------------------------------------------------------'

```

[^1]: https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-configure-networking-in-ubuntu-20-04-with-netplan/
[^2]: https://www.cyberciti.biz/faq/setting-up-an-network-interfaces-file/
[^3]: https://nebulab.com/blog/awesome-motds-with-ubuntu
[^4]: https://www.asciiart.eu/