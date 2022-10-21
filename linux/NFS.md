# How To - Linux - Network File System (Ubuntu) [^1] [^2]

## On the Host (Mount Preparation)

```
sudo mkdir /data
sudo mkdir /export/data
```

```
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

```
sudo apt install nfs-kernel-server
sudo nano /etc/exports
```

```
# <source-folder>   <destination-client>    <options>
/export             xxx.xxx.xxx.xxx			(rw,async,fsid=0,crossmnt,no_subtree_check)
/export/data        xxx.xxx.xxx.xxx			(rw,async,no_subtree_check)
```

```
sudo systemctl restart nfs-kernel-server
```

## On the Client (Import the Exports)

```
sudo apt install nfs-common && modprobe nfs
sudo mkdir /mnt/data
sudo nano /etc/fstab
```

```
############################## Imports ###############################
#<source-device>                <destination>   <type>  <options>   <dump>  <pass>
xxx.xxx.xxx.xxx:/export/data    /mnt/data       nfs4    defaults    0       0
```

```
sudo nano /etc/profile
```

```
umask 0007
```

```
sudo nano /etc/login.defs
```

```
umask 0007
```

```
sudo nano /etc/idmapd.conf
```

```
Domain = localdomain
```

```
sudo mount -a
```

```
sudo findmnt --verify
```

[^1]: https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-18-04
[^2]: https://vitux.com/install-nfs-server-and-client-on-ubuntu/