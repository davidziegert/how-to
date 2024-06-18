# Disk Management (Ubuntu)

## FDISK (max. 2TB) [^1]

### Identify

```bash
sudo lshw -C disk
sudo lsblk
sudo ls /dev/sd*
```

### Partitioning

```bash
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

```bash
sudo ls /dev/sd*
```

### Formatting

```bash
sudo mke4fs -t ext4 /dev/sdb1
```

### Mount

```bash
sudo blkid /dev/sdb1
sudo mkdir /mnt/mynewdrive
sudo nano -Bw /etc/fstab
```

```
#<source-device>    <destination>       <type>  <options>  <dump>  <pass>
/dev/sdb1           /mnt/mynewdrive	    ext4	defaults	0		0
```

```bash
sudo mount -a
```

### Disk Label

```bash
sudo e2label /dev/sdb1 MYDISK
```

### Storage Information

```bash
sudo du -h /mnt/mynewdrive
sudo df -h /mnt/mynewdrive
```

## Logical Volume Manager (2TB up) [^2]

### Identify

```bash
sudo lshw -C disk
sudo lsblk
sudo ls /dev/sd*
```

### Partitioning

```bash
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

```bash
sudo ls /dev/sd*
```

### Create Physical Volumes (PV)

```bash
sudo pvcreate /dev/sdc
sudo pvdisplay
```
### Create Volume Group (1 VG = X PV)

```bash
sudo vgcreate MYVGROUP /dev/sdc
sudo vgdisplay MYVGROUP
```

### Logical Volumes

```bash
sudo lvcreate -L size -n lvname vgname
sudo lvcreate -l 100%FREE -n MYVOLUME MYVGROUP
sudo lvdisplay /dev/MYVGROUP/MYVOLUME
```

### Formatting

```bash
sudo mkfs.ext4 /dev/MYVGROUP/MYVOLUME
```

### Mount

```bash
sudo mkdir /mnt/mynewvolume
sudo nano -Bw /etc/fstab
```

```
#<source-device>            <destination>       <type>  <options>  <dump>  <pass>
/dev/MYVGROUP/MYVOLUME      /mnt/mynewvolume    ext4	defaults	0		0
```

```bash
sudo mount -a
```

### Storage Information

```bash
sudo du -h /mnt/mynewvolume
sudo df -h /mnt/mynewvolume
```

[^1]: https://man7.org/linux/man-pages/man8/fdisk.8.html
[^2]: https://www.thomas-krenn.com/de/wiki/LVM_Grundkonfiguration