# Network File System (Ubuntu) [^1] [^2]

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
```

## On the Host (Mount Preparation)

```bash
sudo mkdir /data
sudo mkdir /export/data
```

```bash
sudo nano /etc/fstab
```

```
############################## External Drives ###############################
#<source-device>    <destination>   <type>  <options>           <dump>  <pass>
/dev/data           /data           ext4    defaults            0       0

######################## Internal Exports (not needed) #######################
#<source-device>    <destination>   <type>  <options>           <dump>  <pass>
/data               /export/data    none    bind                0       0
```

## On the Host (Exports)

```bash
sudo apt install nfs-kernel-server
sudo nano /etc/exports
```

```
# <source-folder>       <destination-client>        <options>
/export                 [IPADDRESS]                 (rw,async,fsid=0,crossmnt,no_subtree_check)
/export/data            [IPADDRESS]                 (rw,async,no_subtree_check)
```

```bash
sudo systemctl restart nfs-kernel-server
```

## On the Client (Import the Exports)

```bash
sudo apt install nfs-common && modprobe nfs
sudo mkdir /mnt/data
sudo nano /etc/fstab
```

```
############################## Imports ###############################
#<source-device>                <destination>       <type>      <options>       <dump>      <pass>
[IPADDRESS]:/export/data        /mnt/data           nfs4        defaults        0           0
```

```bash
sudo nano /etc/profile
```

```
umask 0007
```

```bash
sudo nano /etc/login.defs
```

```
umask 0007
```

```bash
sudo nano /etc/idmapd.conf
```

```
Domain = localdomain
```

```bash
sudo mount -a
```

```bash
sudo findmnt --verify
```

[^1]: https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-18-04
[^2]: https://vitux.com/install-nfs-server-and-client-on-ubuntu/
