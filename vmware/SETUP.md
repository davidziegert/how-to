# VMware - Setup [^1]

```
Open your web browser and enter the IP address of your VMware vSphere Client. Enter your user name in the domain\username format and then enter your password. You can use an administrative account or another account that has enough permissions to create virtual machines in vCenter. Click Login.
```

![Screenshot-1](/files/vm_create_01.webp)

```
Once you have logged in to vCenter 7, click Hosts and Clusters, select your data center, and click the ESXi host on which you want to create a new virtual machine. Click Actions > New virtual machine to start creating a new VM on the selected ESXi host by using VMware vSphere Client.
```

![Screenshot-2](/files/vm_create_02.webp)

## The VM Wizard

```
1. Select a creation type. Click Create a new virtual machine because you need to create a new VM from scratch. If you need to clone a VM or deploy a VM from a template, choose one of the other options. Click Next at each step to continue.
```

![Screenshot-3](/files/vm_create_03.webp)

```
2. Select a name and folder. Enter a name for the new virtual machine. Then select a location for the virtual machine. We will store the new VM in the QA data center.
```

![Screenshot-4](/files/vm_create_04.webp)

```
3. Select a compute resource. Select the ESXi host to run a new virtual machine. As we want to create a new VM on the ESXi host with IP address 10.10.20.86, we select this host in the list. Compatibility checks succeeded means that everything is correct and you can continue.
```

![Screenshot-5](/files/vm_create_05.webp)

```
4. Select storage. Select a datastore where the virtual machine files, including the virtual disk files, will be stored. Make sure that there is enough free space on the selected datastore. In this example, the 86-HDD-R1 datastore is selected.
```

![Screenshot-6](/files/vm_create_06.webp)

```
5. Select compatibility. Select compatibility for this virtual machine depending on the ESXi hosts used in your environment. VMware vCenter 7.0 can be configured to manage ESXi 7.0, ESXi 6.7 and ESXi 6.5 hosts. The ESXi compatibility level defines the virtual machine hardware version. The ESXi 7.0 compatibility level is used for the VM hardware version 17 and supports all vSphere 7 features.

The available options are:
```

- Hardware version 16 – VMware Workstation 15 and ESXi 7.0
- Hardware version 15 – ESXi 6.7 U2 and later
- Hardware version 14 – ESXi 6.7 and later
- Hardware version 13 – ESXi 6.5 and later

![Screenshot-7](/files/vm_create_07.webp)

```
6. Select a guest OS. Select a guest OS family and then select a guest OS version. Selecting the correct guest OS in the list allows the wizard to provide the suitable default configuration of the VM for installing an operating system on the VM.
```

![Screenshot-8](/files/vm_create_08.webp)

```
7. Customize hardware. Configure virtual hardware for the virtual machine. Click the type of hardware to expand settings. In most cases, you can leave the default settings except for:
```

- CPU: select the number of processors and CPU cores.
- Memory: define the amount of RAM.
- Harddisk: select the size of a virtual hard disk and the provisioning type.
- Network: select the network to which a virtual network adapter of the VM must be connected.
- CD/DVD Drive: You need to configure a CD/DVD drive to boot from the operating system installation media and install the operating system. There are multiple options.
    - Client Device – an optical disc inserted into a CD/DVD drive on a client machine is used to boot the operating system installer. You need to insert an optical medium into the DVD-ROM of the computer on which you’re using VMware vSphere Client.
    - Datastore ISO File. Upload an ISO image of the installation disc to the datastore attached to the ESXi host on which you are creating a new VM and are going to install an operating system. Then select the ISO file uploaded on the datastore.
    - Content Library ISO File. Select the needed ISO image file from the Content Library. You should upload the ISO file to the Content Library before you can select the image.

![Screenshot-9](/files/vm_create_09.webp)

```
8. Ready to complete. Check configuration for your new VM and hit Finish to create the new VM.
```

### Harddisk: Controller [^2]

```
ESXi offers several disk controllers to choose from in the virtual hardware, depending on the version of the hypervisor and the guest system. Overall, ESXi supports the BusLogic Parallel, LSI Logic Parallel, LSI Logic SAS and VMware Paravirtual controllers in the guest system for the SCSI controllers as well as AHCI, SATA and NVMe controllers.
```

![Screenshot-10](/files/vm_create_10.png)

- The LSI Logic Parallel driver (formerly known as LSI Logic), on the other hand, supports a queue depth of 32 on most guest operating systems. That's why it was often preferred in the past, even when not every guest system included this driver.
- The LSI Logic SAS is a further development of the parallel driver and has gained enormous importance because it is required for Microsoft Cluster Services from Windows 2008 onwards and is therefore now on board in almost all current guest systems.
- VMware Paravirtual (PVSCSI) is designed to enable very high throughput with minimal processing costs. It is therefore the most efficient driver to date. The performance decision is therefore reduced to LSI Logic SAS versus VMware Paravirtual.
- For Windows from 8.1 and Server 2012 as well as for Linux distributions with a 4-kernel, the choice is reduced to LSI-Logic SAS and VMware Paravirtual (PVSCSI).

![Screenshot-11](/files/vm_create_11.png)

### Harddisk: Provision Types  [^3]  [^4]

When creating a new virtual hard disk, it is possible to configure disk provisioning. The three options “Thick-Provision Lazy-Zeroed”, “Thick-Provision Eager-Zeroed” and “Thin Provision” are available here.

**Thick Provisioning**

```
Thick provisioning is a type of storage pre-allocation. With thick provisioning, the complete amount of virtual disk storage capacity is pre-allocated on the physical storage when the virtual disk is created. A thick-provisioned virtual disk consumes all the space allocated to it in the datastore right from the start, so the space is unavailable for use by other virtual machines. There are two sub-types of thick-provisioned virtual disks:
```

- A Lazy zeroed disk is a disk that takes all of its space at the time of its creation, but this space may contain some old data on the physical media. This old data is not erased or written over, so it needs to be “zeroed out” before new data can be written to the blocks. This type of disk can be created more quickly, but its performance will be lower for the first writes due to the increased IOPS (input/output operations per second) for new blocks;
- An Eager zeroed disk is a disk that gets all of the required space still at the time of its creation, and the space is wiped clean of any previous data on the physical media. Creating eager zeroed disks takes longer, because zeroes are written to the entire disk, but their performance is faster during the first writes. This sub-type of thick-provisioned virtual disk supports clustering features, such as fault tolerance.

![Screenshot-12](/files/vm_create_12.webp)

```
For data security reasons, eager zeroing is more common than lazy zeroing with thick-provisioned virtual disks. Why? When you delete a VMDK, the data on the datastore is not totally erased; the blocks are simply marked as available, until the operating system overwrites them. If you create an eager zeroed virtual disk on this datastore, the disk area will be totally erased (i.e., zeroed), thus preventing anyone with bad intentions from being able to recover the previous data – even if they use specialized third-party software.
```

**Thin Provisioning**

```
Thin provisioning is another type of storage pre-allocation. A thin-provisioned virtual disk consumes only the space that it needs initially, and grows with time according to demand. For example, if you create a new thin-provisioned 30GB virtual disk and copy 10 GB of files to it, the size of the resulting VMDK file will be 10 GB, whereas you would have a 30GB VMDK file if you had chosen to use a thick-provisioned disk.
```

![Screenshot-13](/files/vm_create_13.webp)

```
Thin-provisioned virtual disks are quick to create and useful for saving storage space. The performance of a thin-provisioned disk is not higher than that of a lazy zeroed thick-provisioned disk, because for both of these disk types, zeroes have to be written before writing data to a new block. Note that when you delete your data from a thin-provisioned virtual disk, the disk size is not reduced automatically. This is because the operating system deletes only the indexes from the file table that refer to the file body in the file system; it marks the blocks that belonged to “deleted” files as free and accessible for new data to be written onto. This is why we see file removal as instant. If it were a full deletion, where zeroes were written over the blocks that the deleted files occupied, it would take about the same amount of time as copying the files in question.
```

## Best Practices (possibly outdated) [^5]

**1. Set the most important settings using the vSphere Client**

```
The “Configuration” tab is particularly interesting when a host is clicked in the client. There you can see numerous links on the left that can be used to adjust the host settings. Using the “Processors” menu item in the right area you can see how many sockets are installed in the server. This way, for example, it can be determined whether enough licenses are used for the vSphere hosts. Companies require a vSphere license for each processor. So if a vSphere host with four processors is used, then four licenses are required for this host.
```

**2. Hardware-Assisted CPU Virtualization – VT-x and AMD-V enable**

```
Small companies in particular often fail to activate the processor's virtualization functions. It is even more problematic when servers are used that are not enabled for virtualization. Therefore, only servers that support Intel VT-x or AMD-V should be used. Current Intel processors are superior to AMD processors in terms of performance. The virtualization functions of Intel processors can usually be activated via the BIOS/EFI. There is no need to configure this technology. Once activated, it will be available.

If Intel VT-x is disabled on servers, virtualization solutions such as VMware vSphere 6 will no longer function optimally. For example, if VMs are to be moved between different hosts during operation, the CPU must support this. Since multiple operating systems run in parallel on a server with virtualization, outdated processors are not suitable. Especially when it comes to so-called ring-0 requests, the hypervisor has to intervene and rewrite the requests to the CPU. These processes are time-consuming and significantly slow down performance. Therefore, the virtualization features are important. You can also check whether the processor supports this function using the free CPU-Z tool.
```

**3. Hardware BIOS Settings – Power Management and Turbo Mode**

```
In addition to activating the virtualization functions, other settings should be made in the server's BIOS so that ESXi functions optimally. It is particularly important to set that power management is carried out by the operating system. This can also often be found as “OS Controlled Mode”. This ensures that ESXi itself can use power management. Turbo mode in the BIOS should also be activated. If there is an option “C1E” in the BIOS, this should also be activated. This power saving feature is also supported by ESXi and is necessary for power management.
```

**4. Pay attention to general settings for VMs – protect guest operating systems**

```
The first step in optimizing VMs is to correctly set permissions and roles in the vSphere infrastructure. It should be ensured that only the administrators who need this access have access to the VMs. If you want to prevent vSphere administrators from accessing the guest operating systems, a new role should be created and the “Guest Operations” privilege should be revoked. This prevents vSphere administrators from making administrative changes within the guest operating systems. The setting can be found via “All Rights\Virtual Machine\Guest Operations”.
```

**5. Remove unnecessary hardware**

```
In general, any virtual hardware that is not necessary for a VM should be removed if possible. Serial interfaces or other outdated hardware in particular place a strain on the performance of the host and may also cause security gaps. But it's not just serial interfaces that cause problems, but also the connection of physical CD/DVD drives. If a virtual server no longer requires access to a specific ISO file or physical drive, then that connection should be severed.
```

**6. Use the right network adapters – E1000 or VMXNET**

```
When configuring the virtual machines, you can also specify how many virtual network adapters are assigned to the VM and which virtual networks should be used. The virtual networks that were previously configured in vCenter or the vSphere Client are also displayed here. The type of virtual network adapter is also specified here. The most compatible card is the E1000, but it does not offer the performance of the two adapters VMXNET 2 and 3. If the virtual operating system supports these current adapters, they should also be used. These two types of adapters are paravirtualized and therefore significantly more powerful in most cases.

Older operating systems use E1000 adapters. However, if companies rely on current operating systems, for example Windows Server 2008 R2/2012/2012 R2 or Windows Server 2016, VMXNET 3 adapters should be used. In addition to the performance advantages mentioned, these also have current network functions such as jumbo frames and more. Unlike E1000 adapters, using VMXNET adapters requires ensuring that VMware tools are installed in the VM. In addition, the VM must be installed as hardware version 7 or newer.
```

**7. Choose optimal SCSI adapters**

```
When creating a new VM, you can also specify the desired SCSI adapter on which the virtual hard drives will be operated. BusLogic is particularly suitable for older guest operating systems. The LSI adapters offer better performance for current operating systems. Various options are available here.

The SAS option (Serial Attached Storage) is available from hardware version 7. This adapter is primarily used when current Windows servers starting from Windows Server 2008 R2 are virtualized. Administrators will later also have the option of downloading the appropriate drivers directly from the LSI Logic website. Paravirtual adapters offer significantly higher throughput. These adapters are primarily used when a fast storage system, such as a SAN, is used. However, such adapters should only be used as additional adapters, specifically for access to the fast storage system.
```

**8. Set hard drive formats correctly**

```
When creating a new virtual hard disk, it is possible to configure disk provisioning. The three options “Thick-Provision Lazy-Zeroed”, “Thick-Provision Eager-Zeroed” and “Thin Provision” are available here.

If the “Thin Provision” option is selected, the virtual hard drive is only provided with as much space as it currently needs. If the virtual hard drive requires more memory, this will be provided gradually. Of course, the performance of the VM suffers as a result.

The Thick-Provision Lazy-Zeroed format is the standard format for new virtual disks. This selection will automatically set the virtual disk files to the size that corresponds to the size of the virtual disk. This means that the size of the virtual hard drive does not have to grow, which results in significantly better performance.

The third option “Thick-Provision Eager-Zeroed” is mainly selected if the VM is to be mirrored (Fault Tolerance, FT). With this option, the reserved areas of the hard drive are automatically filled with zeros. Therefore, creating this virtual hard drive takes longer than the other two versions. This type of virtual hard drive is also required for a virtual Windows cluster, for example.
```

**9. Pay attention to the order when updating**

```
To upgrade an entire environment to vSphere 6, administrators should first update the vSphere Client that they use to manage the environment. The vCenter servers should then be updated and only then the individual hosts. The new vSphere Client can also be used to manage older vSphere environments.

Before updating, you should make sure that the hardware of the individual servers is compatible with the new version. In addition, the license numbers may have to be re-entered after the update. A direct upgrade is only possible from vSphere 5 to vSphere 6. If the vCenter Server has been updated, care should also be taken to update other components before updating the hosts.
```

**10. Update virtual servers**

```
If companies have updated their hosts to vSphere 6.0, it may make sense to set the hardware version of the virtual servers to the new version 11. However, before virtual servers are upgraded to hardware version 11, the VMware tools on the virtual servers must be updated.
```

**11. The use of snapshots**

```
Snapshots can never be grouped. When a snapshot is restored, all of the VM's data captured in the snapshot is always restored. If administrators want to back up different states of a VM, they have to create different snapshots. A snapshot not only backs up the virtual hard drives, but also the VM's configuration file.
When a snapshot is created for a database server or an Active Directory domain controller, the snapshot also captures the state of the database and Active Directory. Restoring such a snapshot may cause problems with the database or the Active Directory database. It becomes particularly problematic when the database servers or virtual domain controllers replicate with other domain controls and synchronize stale data from the snapshot to these servers. It may therefore be necessary for such virtual servers to be disconnected from the network first and only then to restore the snapshot.
```

**12. Keep ESXi hosts up to date**

```
VMware regularly releases updates for vSphere. These updates can either be installed via the update manager or installed manually on the individual hosts. This makes sense, for example, if no vCenter is in use. Manually updating vSphere hosts is particularly useful if only a manageable number of hosts are in use or only individual servers in a test environment need to be updated. As soon as VMware makes updates for vSphere available, they can be found in the VMware download portal.
```

## Hostname & Certificates [^6]

### Set Hostname and FQDN via SSH

```
esxcli system hostname set --host=NEWHOSTNAMEHERE
esxcli system hostname set --fqdn=NEWHOSTNAMEHERE.domain.name
```

### Managing Certificates by Using the VMware Host Client [^7]

- Click Manage in the VMware Host Client inventory and click Security & Users.
- Click Certificates and click Import new certificate.
- Generate a certificate signing request:
    - Generate FQDN signing request
    - Generate IP signing request

[^1]: https://www.nakivo.com/blog/how-to-create-a-virtual-machine-using-vsphere-client-7/
[^2]: https://www.windowspro.de/thomas-drilling/virtuelle-disk-controller-fuer-vms-esxi-lsi-logic-sas-vmware-paravirtual
[^3]: https://www.nakivo.com/blog/thick-and-thin-provisioning-difference/
[^4]: https://www.starwindsoftware.com/blog/vmware-esxi-disk-provision-work-difference-one-better
[^5]: https://www.ip-insider.de/12-vmware-best-practices-a-722ae61d5e26bfac199075a4696f82eb/
[^6]: https://kb.vmware.com/s/article/1010821
[^7]: https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-esxi-host-client/GUID-42AAE815-90CF-4D13-A01C-596A345A33DE.html