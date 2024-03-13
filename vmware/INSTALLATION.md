# VMware - Installation

## Requirements for ESXi 7 [^1]

### CPU

```
Two-core x86_64 CPU on the computer where the ESXi host will run. Intel VT-x or AMD-v (RVI) features must be enabled in UEFI/BIOS.
```

### RAM

```
4 GB of RAM to run ESXi and at least 8 GB of RAM to run VMs on an ESXi host. The more memory your computer/server running ESXi has, the more VMs you can run.
```

### Storage

```
At least 8 GB of disk space is required to install and boot ESXi 7.0. ESXi can be installed on a separate HDD or SSD, RAID, and even a USB flash drive or SD card. Be aware that when you install ESXi on a USB flash drive or SD card, there is no persistent /scratch partition to store logs. It is recommended that you provide 32 GB or more on a boot device for ESXi. A boot device must not be shared between multiple ESXi hosts. Opt for SCSI (SAS) disks for VM storage.
```

### Network

```
At least one Gigabit Ethernet network controller. The network adapter must be compatible with ESXi 7.0. Install multiple network adapters on your ESXi server to use NIC Teaming (link aggregation), configure separate This is especially important for using VMware clustering features. It is recommended that you use static IP configuration for vSphere components such as ESXi hosts, vCenter servers, and so on.
```

## Requirements for vCenter 7

- vCenter Server is used to manage ESXi hosts centrally.
- vCenter 7.0 can be deployed only as vCenter virtual appliance (VCSA), that is a virtual machine deployed from a template that runs on an ESXi host. A platform service controller (PSC) is integrated in the VCSA. You cannot install a PSC separately and install vCenter on a Windows machine (although this was possible in vSphere 6.7).
- If you are going to deploy vCenter for a tiny environment (up to 10 hosts or 100 virtual machines), you need to provide 2 vCPUs and 12 GB of RAM. The more hosts and VMs that will be managed by vCenter, the more CPU and memory capacity must be provisioned during installation and the appropriate installation mode must be selected (Tiny, Small, Medium, Large, X-Large).
- Storage requirements for vCenter Server Appliance 7.0 range between 415 GB and 3665 GB depending on the number of virtual machines managed by vCenter.
- Network requirements. The appropriate ports must be open for vCenter to work properly. A static IP address must be set for vCenter.

## The Deployment Scheme

```
In our walkthrough, we are going to install two ESXi servers, deploy vCenter Server Appliance on the first ESXi host and use the second ESXi host to run other VMs. You can add more ESXi hosts and create more VMs in your environment. Main components used in this vSphere installation and setup guide are:
```

- ESXi 1: 192.168.11.30
- ESXi 2: 192.168.11.27
- vCenter: 192.168.11.31
- Gateway/DNS: 192.168.11.2
- Network: 192.168.11.0/255.255.255.0

![Screenshot-1](/files/vmware_scheme.jpg)

## Installing the ESXi Server

![Screenshot-2](/files/vmware_install_1.jpg)
![Screenshot-3](/files/vmware_install_2.jpg)
![Screenshot-4](/files/vmware_install_3.jpg)
![Screenshot-5](/files/vmware_install_4.jpg)
![Screenshot-6](/files/vmware_install_5.jpg)
![Screenshot-7](/files/vmware_install_6.jpg)
![Screenshot-8](/files/vmware_install_7.jpg)
![Screenshot-9](/files/vmware_install_8.jpg)
![Screenshot-10](/files/vmware_install_9.jpg)
![Screenshot-11](/files/vmware_install_10.jpg)
![Screenshot-12](/files/vmware_install_11.jpg)
![Screenshot-13](/files/vmware_install_12.jpg)
![Screenshot-14](/files/vmware_install_13.jpg)

```
http://your-server-ip-address
```

## Creating a Datastore

```
You can create a dedicated datastore to store virtual machine files.
Attach a disk or disks to your ESXi server.
```
> **Note:**
> It is recommended that you use RAID 1 or RAID 10 in production environments to provide redundancy and reduce the probability of data loss in a case of disk damage. However, using RAID cannot replace data backups. Please perform VMware VM backup in production environments to protect data.

![Screenshot-15](/files/vmware_datastore_1.jpg)
![Screenshot-16](/files/vmware_datastore_2.jpg)
![Screenshot-17](/files/vmware_datastore_3.jpg)
![Screenshot-18](/files/vmware_datastore_4.jpg)
![Screenshot-19](/files/vmware_datastore_5.jpg)
![Screenshot-20](/files/vmware_datastore_6.jpg)
![Screenshot-21](/files/vmware_datastore_7.jpg)

## Deploying vCenter Server [^1] [^2]

![Screenshot-22](/files/vcenter_install_1.jpg)
![Screenshot-23](/files/vcenter_install_2.jpg)
![Screenshot-24](/files/vcenter_install_3.jpg)
![Screenshot-25](/files/vcenter_install_4.jpg)
![Screenshot-26](/files/vcenter_install_5.jpg)
![Screenshot-27](/files/vcenter_install_6.jpg)
![Screenshot-28](/files/vcenter_install_7.jpg)
![Screenshot-29](/files/vcenter_install_8.jpg)
![Screenshot-30](/files/vcenter_install_9.jpg)
![Screenshot-31](/files/vcenter_install_10.jpg)
![Screenshot-32](/files/vcenter_install_11.jpg)
![Screenshot-33](/files/vcenter_install_12.jpg)
![Screenshot-34](/files/vcenter_install_13.jpg)
![Screenshot-35](/files/vcenter_install_14.jpg)
![Screenshot-36](/files/vcenter_install_15.jpg)
![Screenshot-37](/files/vcenter_install_16.jpg)
![Screenshot-38](/files/vcenter_install_17.jpg)
![Screenshot-39](/files/vcenter_install_18.jpg)
![Screenshot-40](/files/vcenter_install_19.jpg)

## Creating a Datacenter

```
http://your-server-ip-address
```

![Screenshot-41](/files/vcenter_datacenter_1.jpg)
![Screenshot-42](/files/vcenter_datacenter_2.jpg)
![Screenshot-43](/files/vcenter_datacenter_3.jpg)

## Adding ESXi Hosts

![Screenshot-44](/files/vcenter_host_1.jpg)
![Screenshot-45](/files/vcenter_host_2.jpg)
![Screenshot-46](/files/vcenter_host_3.jpg)
![Screenshot-47](/files/vcenter_host_4.jpg)
![Screenshot-48](/files/vcenter_host_5.jpg)
![Screenshot-49](/files/vcenter_host_6.jpg)
![Screenshot-50](/files/vcenter_host_7.jpg)
![Screenshot-51](/files/vcenter_host_8.jpg)
![Screenshot-52](/files/vcenter_host_9.jpg)
![Screenshot-53](/files/vcenter_host_10.jpg)

[^1]: https://www.nakivo.com/blog/vmware-vsphere-7-installation-setup/
[^2]: https://esxsi.com/2021/01/27/vsphere7-install-2/