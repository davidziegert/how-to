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
sudo e2label /dev/sdb1 [DISKNAME]
```

### Storage Information

```bash
sudo du -h /mnt/[DISKNAME]
sudo df -h /mnt/[DISKNAME]
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
sudo vgcreate [GROUPNAME] /dev/sdc
sudo vgdisplay [GROUPNAME]
```

### Logical Volumes

```bash
sudo lvcreate -L size -n lvname vgname
sudo lvcreate -l 100%FREE -n [VOLUMENAME] [GROUPNAME]
sudo lvdisplay /dev/[GROUPNAME]/[VOLUMENAME]
```

### Formatting

```bash
sudo mkfs.ext4 /dev/[GROUPNAME]/[VOLUMENAME]
```

### Mount

```bash
sudo mkdir /mnt/[VOLUMENAME]
sudo nano -Bw /etc/fstab
```

```
#<source-device>                    <destination>           <type>      <options>       <dump>      <pass>
/dev/[GROUPNAME]/[VOLUMENAME]       /mnt/[VOLUMENAME]       ext4        defaults	    0           0
```

```bash
sudo mount -a
```

### Storage Information

```bash
sudo du -h /mnt/[VOLUMENAME]
sudo df -h /mnt/[VOLUMENAME]
```

[^1]: https://man7.org/linux/man-pages/man8/fdisk.8.html
[^2]: https://www.thomas-krenn.com/de/wiki/LVM_Grundkonfiguration
