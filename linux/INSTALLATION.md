# How To - Linux - Installation (Ubuntu)

![Screenshot-1](/files/linux_install_1.png)
![Screenshot-2](/files/linux_install_2.png)
![Screenshot-3](/files/linux_install_3.png)
![Screenshot-4](/files/linux_install_4.png)
![Screenshot-5](/files/linux_install_5.png)
![Screenshot-6](/files/linux_install_6.png)
![Screenshot-7](/files/linux_install_7.png)
![Screenshot-8](/files/linux_install_8.png)
![Screenshot-9](/files/linux_install_9.png)
![Screenshot-10](/files/linux_install_10.png)
![Screenshot-11](/files/linux_install_11.png)
![Screenshot-12](/files/linux_install_12.png)
![Screenshot-13](/files/linux_install_13.png)
![Screenshot-14](/files/linux_install_14.png)
![Screenshot-15](/files/linux_install_15.png)
![Screenshot-16](/files/linux_install_16.png)
![Screenshot-17](/files/linux_install_17.png)

## Updates

```
sudo apt-get update
sudo apt-get upgrade
```

## Cleanup

```
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove
```

## Cleanup via CronJob [^5]

```
sudo nano ucleaner.sh
```

```
echo "\n\nSYSTEM CLEANUP\n\n"
echo "-------------------------------------------------------\n\n"

if [ $USER != root ]; then
  echo "\nError: must be root"
  echo "\nExiting..."
  exit 0
fi

echo "\n\nBefore command execution:-"
free -h 

echo "\n\nClearing caches..."
sync; echo 1 > /proc/sys/vm/drop_caches

echo "\n\nRemoving old kernels..."
echo "Current kernel:-"
a=`uname -r|cut -f "2" -d "-"`
a=$(($a-2))
apt-get remove --purge linux-image-3.16.0-$a-generic

echo "\n\nClearing swap space..."
swapoff -a && swapon -a

echo "\n\nClearing application dependencies..."
apt-get clean
apt-get autoclean
apt-get autoremove

echo "\n\nEmptying every trashes..."
rm -rf /home/*/.local/share/Trash/*/** 
rm -rf /root/.local/share/Trash/*/** 

echo "\n\nAfter command execution:-"
free -h
```

```
sudo crontab -e
```

```
# Every Monday on 05:00 AM  
0 5 * * 1	/home/ucleaner.sh
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
NTP=time.uni-potsdam.de
FallbackNTP=times.tubit.tu-berlin.de
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
[^5]: https://github.com/jenil777007/ucleaner