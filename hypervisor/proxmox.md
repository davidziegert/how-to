# Proxmox

## Hardware Requirements

- Intel EMT64 or AMD64 with Intel VT/AMD-V CPU flag.
- Memory, minimum 2 GB for OS and Proxmox VE services. Plus designated memory for guests. For Ceph or ZFS additional memory is required, approximately 1 GB memory for every TB used storage.
- Fast and redundant storage, best results with SSD disks.
- OS storage: Hardware RAID with batteries protected write cache (“BBU”) or non-RAID with ZFS and SSD cache.
- VM storage: For local storage use a hardware RAID with battery backed write cache (BBU) or non-RAID for ZFS. Neither ZFS nor Ceph are compatible with a hardware RAID controller. Shared and distributed storage is also possible.
- Redundant Gbit NICs, additional NICs depending on the preferred storage technology and cluster setup – 10 Gbit and higher is also supported.
- For PCI(e) passthrough a CPU with VT-d/AMD-d CPU flag is needed.

## Installation

![Screenshot-2](./assets/vmware_install_1.jpg)
![Screenshot-3](./assets/vmware_install_2.jpg)
![Screenshot-4](./assets/vmware_install_3.jpg)
![Screenshot-5](./assets/vmware_install_4.jpg)
![Screenshot-6](./assets/vmware_install_5.jpg)
![Screenshot-7](./assets/vmware_install_6.jpg)
![Screenshot-8](./assets/vmware_install_7.jpg)
![Screenshot-9](./assets/vmware_install_8.jpg)
![Screenshot-10](./assets/vmware_install_9.jpg)
![Screenshot-11](./assets/vmware_install_10.jpg)
![Screenshot-12](./assets/vmware_install_11.jpg)
![Screenshot-13](./assets/vmware_install_12.jpg)
![Screenshot-14](./assets/vmware_install_13.jpg)

## Security

## Backup
