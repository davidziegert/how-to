# Proxmox

## Installation [1] [2]

The Proxmox VE menu appears. Select Install Proxmox VE to start the standard installation.

![Step 01](./assets/proxmox_installer_01.webp)

Read and accept the EULA to continue.

![Step 02](./assets/proxmox_installer_02.webp)

Choose the target hard disk where you want to install Proxmox. Click Options to specify additional parameters, such as the filesystem. By default, it is set to ext4.

![Step 03](./assets/proxmox_installer_03.webp)

In the target disk step, click on Options to create a ZFS RAID1 and the disks on which you are going to install the Proxmox hypervisor. Select do not use for the others disks:

![Step 04](./assets/proxmox_installer_04.webp)

Next, set the location, time zone, and keyboard layout. The installer autodetects most of these configurations.

![Step 05](./assets/proxmox_installer_05.webp)

Create a strong password for your admin credentials, retype the password to confirm, and type in an email address for system administrator notifications.

![Step 06](./assets/proxmox_installer_06.webp)

The final step in installing Proxmox is setting up the network configuration. Select the management interface, a hostname for the server, an available IP address, the default gateway, and a DNS server. During the installation process, use either an IPv4 or IPv6 address. To use both, modify the configuration after installing.

![Step 07](./assets/proxmox_installer_07.webp)

The installer summarizes the selected options. After confirming everything is in order, press Install.

![Step 08](./assets/proxmox_installer_08.webp)

Once the system reboots, the Proxmox GRUB menu loads. Select Proxmox Virtual Environment GNU/Linux and press Enter. Next, the Proxmox VE welcome message appears. It includes an IP address that loads Proxmox. Navigate to that IP address in a web browser of your choice.

![Step 09](./assets/proxmox_installer_09.webp)

## Post Installation

This script provides options for managing Proxmox VE repositories, including disabling the Enterprise Repo, adding or correcting PVE sources, enabling the No-Subscription Repo, adding the test Repo, disabling the subscription nag, updating Proxmox VE, and rebooting the system. Run the command below in the Proxmox VE Shell to install PVE Post Install.

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/pve-scripts-local.sh)"
```

What it does:

- Switch to No-Subscription Repository
- Disable Subscription Warning Popup
- Update & Upgrade System
- Remove Enterprise Repo Files (optional cleanup)
- Enable Useful Services / Tools
- Set CPU Scaling Governor (optional)
- Fix or Configure Network (optional)
- Enable IOMMU / Virtualization Tweaks (optional)
- Install Container Templates (optional)
- Add Helper Scripts / Menu
- Disable Unnecessary Services (optional)
- Configure Time Sync (NTP)

## Configuration

### Add ZFS Storage

1. Select Node: In the Proxmox GUI, click on your specific node (e.g., pve).
2. Navigate to ZFS: Go to Disks -> ZFS.
3 .Create ZFS Pool: Click the Create: ZFS button.
4. Configure Pool:
    - Name: Give the storage a name (e.g., tank).
    - RAID Level: Choose the desired level (e.g., RAID10, RAIDZ1/2/3) based on your performance and redundancy needs.
    - Disks: Check the boxes to select the drives you want to add to the pool.
    - Compression: Enabled by default (recommended).
5. Finish: Click Create. Proxmox will format the disks and mount the pool.

![Step 10](./assets/proxmox_zfs_01.webp)

![Step 11](./assets/proxmox_zfs_02.webp)

### Add Network Bridge

1. Select Node: In the Proxmox GUI, click on your specific node (e.g., pve).
2. Navigate to Create: Go to System -> Network.
3. Create the Linux Bridge (Host Level):
    - Name it (e.g., vmbr1).
    - Leave "Bridge ports" blank if it is an internal-only network, or enter a physical NIC name to bridge it to the physical network.
4. Finish: Click Create, then Apply Configuration.

![Step 11](./assets/proxmox_bridge_01.webp)

### Create a VM [5]

Log in to Proxmox VE Webinterface and click on Create VM.

![Step 12](./assets/proxmox_create_vm_01.png)

Choose a name for the VM and click on Advanced if you want to see further information.

![Step 13](./assets/proxmox_create_vm_02.png)

Click on Next.

![Step 14](./assets/proxmox_create_vm_03.png)

Select the desired ISO Image for the installation. 

![Step 15](./assets/proxmox_create_vm_04.png)

Click on Next.

![Step 16](./assets/proxmox_create_vm_05.png)

Adjust the system options as needed and click on Next.

![Step 17](./assets/proxmox_create_vm_06.png)

Select the desired size of the virtual drive and click on Next.

![Step 18](./assets/proxmox_create_vm_07.png)

Check the selected CPU type and click on Next.

![Step 19](./assets/proxmox_create_vm_08.png)

Select the desired amount of RAM and click on Next.

![Step 20](./assets/proxmox_create_vm_09.png)

Select your desired network and click on Next.

![Step 21](./assets/proxmox_create_vm_10.png)

Check the settings and click Finish.

![Step 22](./assets/proxmox_create_vm_11.png)

#### Installation of qemu-guest-agent for the guest os

The qemu-guest-agent is a helper daemon, which is installed in the guest. It is used to exchange information between the host and guest, and to execute command in the guest.

In Proxmox VE, the qemu-guest-agent is used for mainly two things:

1. To properly shutdown the guest, instead of relying on ACPI commands or windows policies
2. To freeze the guest file system when making a backup/snapshot (on windows, use the volume shadow copy service VSS). If the guest agent is enabled and running, it calls guest-fsfreeze-freeze and guest-fsfreeze-thaw to improve consistency.

![Step 23](./assets/proxmox_create_vm_12.png)

##### On Linux

```bash
sudo apt install -y qemu-guest-agent
sudo systemctl start qemu-guest-agent
sudo systemctl enable qemu-guest-agent
```

##### On Windows

First you have to [download](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/?C=M;O=D) the virtio-win driver iso (see Windows VirtIO Drivers).

Then install the virtio-serial driver:

1. Attach the ISO to your windows VM (virtio-*.iso)
2. Go to the windows Device Manager
3. Look for "PCI Simple Communications Controller"
4. Right Click -> Update Driver and select on the mounted iso in DRIVE:\vioserial\<OSVERSION>\ where <OSVERSION> is your Windows Version (e.g. 2k12R2 for Windows 2012 R2)

After that, you have to install the qemu-guest-agent:

1. Go to the mounted ISO in explorer
2. The guest agent installer is in the directory guest-agent
3. Execute the installer with double click

After that the qemu-guest-agent should be up and running. You can validate this in the list of Window Services, or in a PowerShell with:

```powershell
Get-Service QEMU-GA
```

## Security

### SSH

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
sudo sshd -T
sudo nano /etc/ssh/sshd_config
```

```
Protocol 2
Port MY_SSHPORT
PermitRootLogin yes
PermitEmptyPasswords no
PasswordAuthentication yes
PubkeyAuthentication yes
MaxAuthTries 3
```

```bash
sudo service ssh restart
```

### ACL

```bash
sudo nano /etc/hosts.allow
```

```
sshd : localhost : allow
sshd : xxx.xxx.xxx.0/24 : allow
sshd : ALL : deny
```

### fail2ban

```bash
sudo apt install -y fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

Add these lines to the under named sections:

```
[default]
allowipv6 = auto
backend = systemd
```

```
[sshd]
enabled = true
```

```
[proxmox]
enabled = true
port = https,http,8006
filter = proxmox
backend = systemd
maxretry = 3
findtime = 2d
bantime = 1h
```

```bash
sudo nano /etc/fail2ban/filter.d/proxmox.conf
```

```
[Definition]
failregex = pvedaemon\[.*authentication failure; rhost=<HOST> user=.* msg=.*
ignoreregex =
```

```bash
systemctl enable fail2ban
systemctl start fail2ban
systemctl status fail2ban
```

Now incoming login attempts to the Proxmox web interface are monitored by Fail2Ban and potential attackers are blocked for one hour after just 3 invalid login attempts.

[1]: https://std.rocks/virtualization_proxmox_install.html
[2]: https://phoenixnap.com/kb/install-proxmox
[3]: https://edywerder.ch/vmware-to-proxmox/
[4]: https://www.vinchin.com/vm-tips/proxmox-move-disk-to-another-storage.html
[5]: https://www.thomas-krenn.com/en/wiki/Creation_of_Proxmox_Ubuntu_24.04_server_VM