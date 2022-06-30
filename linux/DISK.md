# How To - Linux - Disk Management (Ubuntu)

## FDISK (max. 2TB) [^1]

### Identify

```
sudo lshw -C disk
sudo lsblk
sudo ls /dev/sd*
```

### Partitioning

```
sudo fdisk -l /dev/sdb
```

```
m "for help"
n "new partition"
p "primary partition"
1 "number of partitions"
ENTER "first sector"
ENTER "last sector"
w "write table to disk and exit"
```

```
sudo ls /dev/sd*
```

### Formatting

```
sudo mke4fs -t ext4 /dev/sdb1
```

### Mount

```
sudo blkid /dev/sdb1
sudo mkdir /mnt/mynewdrive
sudo nano -Bw /etc/fstab
```

```
#<source-device>    <destination>       <type>  <options>  <dump>  <pass>
/dev/sdb1           /mnt/mynewdrive	    ext4	defaults	0		0
```

```
sudo mount -a
```

### Disk Label

```
sudo e2label /dev/sdb1 MYDISK
```

### Storage Information

```
sudo du -h /mnt/mynewdrive
sudo df -h /mnt/mynewdrive
```

## Logical Volume Manager (2TB up) [^2]

### Identify

```
sudo lshw -C disk
sudo lsblk
sudo ls /dev/sd*
```

### Partitioning

```
sudo fdisk -l /dev/sdc
```

```
m "for help"
n "new partition"
p "primary partition"
1 "number of partitions"
ENTER "first sector"
ENTER "last sector"
w "write table to disk and exit"
```

```
sudo ls /dev/sd*
```

### Create Physical Volumes (PV)

```
sudo pvcreate /dev/sdc
sudo pvdisplay
```
### Create Volume Group (1 VG = X PV)

```
sudo vgcreate MYVGROUP /dev/sdc
sudo vgdisplay MYVGROUP
```

### Logical Volumes

```
sudo lvcreate -L size -n lvname vgname

sudo lvcreate -l 100%FREE -n MYVOLUME MYVGROUP

sudo lvdisplay /dev/MYVGROUP/MYVOLUME
```

### Formatting

```
sudo mkfs.ext4 /dev/MYVGROUP/MYVOLUME
```

### Mount

```
sudo mkdir /mnt/mynewvolume
sudo nano -Bw /etc/fstab
```

```
#<source-device>            <destination>       <type>  <options>  <dump>  <pass>
/dev/MYVGROUP/MYVOLUME      /mnt/mynewvolume    ext4	defaults	0		0
```

```
sudo mount -a
```

### Storage Information

```
sudo du -h /mnt/mynewvolume
sudo df -h /mnt/mynewvolume
```

[^1]: https://man7.org/linux/man-pages/man8/fdisk.8.html
[^2]: https://www.thomas-krenn.com/de/wiki/LVM_Grundkonfiguration