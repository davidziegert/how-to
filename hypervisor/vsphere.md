# vSphere

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
```

## Hardware Requirements for ESXi 7

- Two-core x86_64 CPU on the computer where the ESXi host will run. Intel VT-x or AMD-v (RVI) features must be enabled in UEFI/BIOS.
- 4 GB of RAM to run ESXi and at least 8 GB of RAM to run VMs on an ESXi host. The more memory your computer/server running ESXi has, the more VMs you can run.
- At least 8 GB of disk space is required to install and boot ESXi 7.0. ESXi can be installed on a separate HDD or SSD, RAID, and even a USB flash drive or SD card.
- Be aware that when you install ESXi on a USB flash drive or SD card, there is no persistent /scratch partition to store logs. It is recommended that you provide 32 GB or more on a boot device for ESXi. A boot device must not be shared between multiple ESXi hosts. Opt for SCSI (SAS) disks for VM storage.
- At least one Gigabit Ethernet network controller. The network adapter must be compatible with ESXi 7.0. Install multiple network adapters on your ESXi server to use NIC Teaming (link aggregation), configure separate This is especially important for using VMware clustering features. It is recommended that you use static IP configuration for vSphere components such as ESXi hosts, vCenter servers, and so on.

## Hardware Requirements for vCenter 7

- vCenter Server is used to manage ESXi hosts centrally.
- vCenter 7.0 can be deployed only as vCenter virtual appliance (VCSA), that is a virtual machine deployed from a template that runs on an ESXi host. A platform service controller (PSC) is integrated in the VCSA. You cannot install a PSC separately and install vCenter on a Windows machine (although this was possible in vSphere 6.7).
- If you are going to deploy vCenter for a tiny environment (up to 10 hosts or 100 virtual machines), you need to provide 2 vCPUs and 12 GB of RAM. The more hosts and VMs that will be managed by vCenter, the more CPU and memory capacity must be provisioned during installation and the appropriate installation mode must be selected (Tiny, Small, Medium, Large, X-Large).
- Storage requirements for vCenter Server Appliance 7.0 range between 415 GB and 3665 GB depending on the number of virtual machines managed by vCenter.
- Network requirements. The appropriate ports must be open for vCenter to work properly. A static IP address must be set for vCenter.

## The Deployment Scheme

In our walkthrough, we are going to install two ESXi servers, deploy vCenter Server Appliance on the first ESXi host and use the second ESXi host to run other VMs. You can add more ESXi hosts and create more VMs in your environment. Main components used in this vSphere installation and setup guide are:

- ESXi 1: 192.168.11.30
- ESXi 2: 192.168.11.27
- vCenter: 192.168.11.31
- Gateway/DNS: 192.168.11.2
- Network: 192.168.11.0/255.255.255.0

![Screenshot-1](./assets/vmware_scheme.jpg)

## Installing the ESXi Server

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

> **Note:**
> http://[IPADDRESS]

## Creating a Datastore

You can create a dedicated datastore to store virtual machine files. Attach a disk or disks to your ESXi server.

> **Note:**
> It is recommended that you use RAID 1 or RAID 10 in production environments to provide redundancy and reduce the probability of data loss in a case of disk damage. However, using RAID cannot replace data backups. Please perform VMware VM backup in production environments to protect data.

![Screenshot-15](./assets/vmware_datastore_1.jpg)
![Screenshot-16](./assets/vmware_datastore_2.jpg)
![Screenshot-17](./assets/vmware_datastore_3.jpg)
![Screenshot-18](./assets/vmware_datastore_4.jpg)
![Screenshot-19](./assets/vmware_datastore_5.jpg)
![Screenshot-20](./assets/vmware_datastore_6.jpg)
![Screenshot-21](./assets/vmware_datastore_7.jpg)

## Deploying vCenter Server [^2] [^3]

![Screenshot-22](./assets/vcenter_install_1.jpg)
![Screenshot-23](./assets/vcenter_install_2.jpg)
![Screenshot-24](./assets/vcenter_install_3.jpg)
![Screenshot-25](./assets/vcenter_install_4.jpg)
![Screenshot-26](./assets/vcenter_install_5.jpg)
![Screenshot-27](./assets/vcenter_install_6.jpg)
![Screenshot-28](./assets/vcenter_install_7.jpg)
![Screenshot-29](./assets/vcenter_install_8.jpg)
![Screenshot-30](./assets/vcenter_install_9.jpg)
![Screenshot-31](./assets/vcenter_install_10.jpg)
![Screenshot-32](./assets/vcenter_install_11.jpg)
![Screenshot-33](./assets/vcenter_install_12.jpg)
![Screenshot-34](./assets/vcenter_install_13.jpg)
![Screenshot-35](./assets/vcenter_install_14.jpg)
![Screenshot-36](./assets/vcenter_install_15.jpg)
![Screenshot-37](./assets/vcenter_install_16.jpg)
![Screenshot-38](./assets/vcenter_install_17.jpg)
![Screenshot-39](./assets/vcenter_install_18.jpg)
![Screenshot-40](./assets/vcenter_install_19.jpg)

## Creating a Datacenter

> **Note:**
> http://[IPADDRESS]

![Screenshot-41](./assets/vcenter_datacenter_1.jpg)
![Screenshot-42](./assets/vcenter_datacenter_2.jpg)
![Screenshot-43](./assets/vcenter_datacenter_3.jpg)

## Adding ESXi Hosts

![Screenshot-44](./assets/vcenter_host_1.jpg)
![Screenshot-45](./assets/vcenter_host_2.jpg)
![Screenshot-46](./assets/vcenter_host_3.jpg)
![Screenshot-47](./assets/vcenter_host_4.jpg)
![Screenshot-48](./assets/vcenter_host_5.jpg)
![Screenshot-49](./assets/vcenter_host_6.jpg)
![Screenshot-50](./assets/vcenter_host_7.jpg)
![Screenshot-51](./assets/vcenter_host_8.jpg)
![Screenshot-52](./assets/vcenter_host_9.jpg)
![Screenshot-53](./assets/vcenter_host_10.jpg)

[^2]: https://www.nakivo.com/blog/vmware-vsphere-7-installation-setup/
[^3]: https://esxsi.com/2021/01/27/vsphere7-install-2/

## Security

> **Note:**
> The ESXi hypervisor is secured out of the box. You can further protect ESXi hosts by using lockdown mode and other built-in features. For consistency, you can set up a reference host and keep all hosts in sync with the host profile of the reference host. You can also protect your environment by performing scripted management, which ensures that changes apply to all hosts. You can enhance protection of ESXi hosts that are managed by vCenter Server with the following actions. See the Security of the VMware vSphere Hypervisor white paper for background and details.

### TPM 2.0 [^4]

TPM 2.0 is a hardware chip that most modern physical servers have. It allows the operating system (ESXi in our case) to store secrets, keys, measurements etc. in a secure manner. This is used by vCenter Server to make sure the ESXi hosts’ boot files haven’t been tampered with, and works with vSphere/ESXi 6.7 and newer.

For the vSphere Attestation, there isn’t any specific configuration that needs to be set. If your ESXi hosts have active TPM 2.0 chips, vCenter Server will automatically display their attestation status in the ‘Monitor->Security’ tab of the clusters.

In vSphere 7.0 U2 and newer, the TPM 2.0 chip is also used to encrypt the configuration of the ESXi host as well as protect some settings from tampering (called ‘enforcement’).

![Screenshot-1](./assets/vmware_secure_1.png)

### Secure Boot [^4]

Secure Boot is a UEFI BIOS feature that strengthens the security of the operating system (ESXi in this case) by making sure that all code that is loaded at boot is digitally signed and has not been tampered with. It also adds the benefit of disallowing threat actors from circumventing your set VIB ‘Acceptance level’ by them simply adding ‘–force’ at the end of the installation command.

However, there might be some installation packages (‘VIBs’, in vSphere language) that are not approved/signed by VMware or partners. These will then have the wrong ‘Acceptance level’ and can prevent Secure Boot from working correctly. To check if your ESXi host already has Secure Boot enabled, and whether there are any obstacles to enabling it, run the following two commands from an ESXi command line (SSH or ESXi Shell):

- /usr/lib/vmware/secureboot/bin/secureBoot.py -s
- /usr/lib/vmware/secureboot/bin/secureBoot.py -c

In vSphere 7.0 U2, the Secure Boot setting can be protected from tampering using the ‘enforcement’ capability. This is set using the following command line:

```bash
esxcli system settings encryption set --require-secure-boot=TRUE
```

### execInstalledOnly [^4]

The execInstalledOnly setting prohibits execution of custom code inside ESXi and will make the ESXi host simply refuse to execute anything that was not installed through a signed VIB package from a certified partner.

The setting is found in ESXi under Manage->Advanced Settings at VMkernel.Boot.execInstalledOnly and it can be set without having to open a CLI to each ESXi host. We can set it for individual ESXi hosts using the vSphere Web Client or for multiple ESXi hosts at a time using PowerCLI

The default setting of an ESXi host is that execInstalledOnly is set to FALSE. We can verify this by simply listing the setting using:

```bash
esxcli system settings kernel list -o execinstalledonly
```

Now, we set the execInstalledOnly setting to TRUE using:

```bash
esxcli system settings kernel set -s execinstalledonly -v TRUE
```

In vSphere 7.0 U2, the execInstalledOnly setting can be protected from tampering using the ‘enforcement’ capability. This is set using the following command line:

````

```bash
esxcli system settings encryption set –require-exec-installed-only=TRUE
````

#### Patching with execInstalledOnly [^4]

If you are updating/patching ESXi hosts using vSphere Lifecycle Manager (formerly known as Update Manager) using the old fashioned Baseline method rather than the newer Image method you will bump into problems when having execInstalledOnly set to TRUE.

The recommended workaround is to switch to the Image method, since it will also bring other benefits. If you can’t switch, you will unfortunately need to wait until vSphere 8.0 before being able to enable execInstalledOnly.

When using the baseline method and enabling execInstalledOnly, the error message you will get when scanning an ESXi host for patch compliance is: "Cannot deploy host upgrade agent. Ensure that vSphere Lifecycle Manager is officially signed. Check the network connectivity and logs of host agent and vpxa for details."

### Updates/Patches

Keep your ESXi hosts up to date with the latest security patches and updates. Regularly check for vendor-provided patches and apply them promptly to address any known vulnerabilities.

Check VIB package integrity:
Each VIB package has an associated acceptance level. You can add a VIB to an ESXi host only if the VIB acceptance level is the same or better than the acceptance level of the host. You cannot add a CommunitySupported or PartnerSupported VIB to a host unless you explicitly change the host's acceptance level.

#### Offline Bundle via Command Line [^5]

- Go to the Customer Connect Patch Downloads page: https://my.vmware.com/group/vmware/patch#search
- Log in with your Customer Connect credentials.
- Select a product from the list and then select the version.
- Click Search. You see the list of available patches.
- Locate your patch and click Download.

- Upload the updates to the ESXi host. This is possible, for example, via the datastore browser of the vSphere Web Client.
- In the Web Client, enable the SSH Shell
- Log into the host via SSH. You can use putty, the terminal, or your favorite SSH client.
- Stop or migrate all virtual machines, and then put the host in maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e true
- Check maintenance mode: [root@localhost:~] esxcli system maintenanceMode get
- Then install the updates using the esxcli command as follows: [root@localhost:~] esxcli software vib update -d /vmfs/volumes/datastore1/updates/offline_bundle.zip
- You can also check the versions that have just been imported using esxcli: [root@localhost:~] esxcli software vib list

- Now perform a reboot: [root@localhost:~] esxcli system shutdown reboot -r "Update ESXi"
- After the reboot, exit maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e false

#### Online Bundle via Command Line [^6]

- Log into the host via SSH. You can use putty, the terminal, or your favorite SSH client.
- Stop or migrate all virtual machines, and then put the host in maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e true
- Check maintenance mode: [root@localhost:~] esxcli system maintenanceMode get
- Check the profile version you are running: [root@localhost:~] esxcli software profile get
- Enable the host firewall rule to allow web traffic: [root@localhost:~] esxcli network firewall ruleset set -e true -r httpClient
- List the online depot profiles available to you: [root@localhost:~] esxcli software sources profile list -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml | grep -i ESXi-6
- Select the package you want to install and insert it into the command: [root@localhost:~] esxcli software profile update -p PACKAGE-NAME -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml (ESXi 7 Example: esxcli software profile update -p ESXi-7.0U3o-22348816-standard \ -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml)
- Now perform a reboot: [root@localhost:~] esxcli system shutdown reboot -r "Update ESXi"
- After the reboot, disable the host firewall rule to allow web traffic: [root@localhost:~] esxcli network firewall ruleset set -e false -r httpClient
- After the reboot, exit maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e false

#### vSphere Update Manager (VUM)

Check: https://core.vmware.com/resource/vsphere-update-manager#section1

> **Renamed:**
> vSphere Update Manager (VUM) to vSphere Lifecycle Manager (VLCM)

#### vSphere Lifecycle Manager (VLCM)

Check: https://cherrypicking.dev/update-esxi-hosts-using-lifecycle-manager/

### Accounts, Passwords and Role Management (RBAC)

- Role-Based Access Control (RBAC): Utilize RBAC to define and assign roles with specific privileges and permissions to users and groups. Regularly review and update role assignments to align with organizational changes.
- Secure Password Policies: Enforce strong password policies for ESXi host access. Set password complexity requirements, such as minimum length, character combinations, and expiration periods.
- Two-Factor Authentication (2FA): Implement 2FA to add an extra layer of security to ESXi host access. This requires users to provide a second form of authentication, typically a one-time password or a token, in addition to their regular credentials. 2FA significantly strengthens access controls by reducing the risk of unauthorized access in case of password compromise.

#### ESXi Passwords

ESXi uses the Linux PAM module pam_passwdqc for password management and control. We can change the required length, character class requirement, or allow pass phrases using the ESXi Advanced setting Security.PasswordQualityControl.

retry=3 min=disabled,disabled,disabled,7,7

What does these placeholders mean?

- 3
  - an admin has three attempts to retry a password
- disabled
  - Number of minimum characters required if the password contains only one character class
- disabled
  - Number of minimum characters required if the password contains characters from two character classes
- disabled
  - Number of minimum characters required if the password contains a phrase
- 7
  - Number of minimum characters required if the password contains characters from three character classes
- 7
  - Number of characters required if the password contains characters from four character classes

![Screenshot-2](./assets/vmware_secure_2.webp)

#### ESXi Passphrase

Instead of a password, you can also use a pass phrase. However, pass phrases are disabled by default. You can change the default setting and other settings by using the Security.PasswordQualityControl advanced option from the vSphere Client.

retry=3 min=disabled,disabled,16,7,7

This example allows pass phrases of at least 16 characters and at least three words.

### Encryption

Secure Encrypted Virtualization (SEV): If using AMD processors that support SEV, enable this feature to encrypt virtual machine memory, isolating it from other virtual machines and the hypervisor. SEV provides an additional layer of protection against memory-based attacks and unauthorized access to virtual machine data.

Encrypted vMotion: Enable Encrypted vMotion to encrypt data transferred between ESXi hosts during live migrations. Encrypted vMotion protects against eavesdropping and data interception, ensuring the confidentiality and integrity of virtual machine data during migrations.

Secure Communication Protocols: Utilize secure communication protocols to protect data transmitted over the management network. Enable and enforce Secure Socket Layer (SSL)/Transport Layer Security (TLS) encryption for management interfaces, such as vSphere Web Client or vSphere Client. This ensures that communications between clients and ESXi hosts are encrypted and secure. Avoid using unencrypted protocols like HTTP or Telnet for management purposes.

### Lockdown Mode [^7] [^8]

In lockdown mode, ESXi hosts can be accessed only through vCenter Server by default. You can select strict lockdown mode or normal lockdown mode. You can define Exception Users to allow direct access to service accounts such as backup agents.

Normal-Mode: The host can be accessed through vCenter Server. Only users who are on the Exception Users list and have administrator privileges can log in to the Direct Console User Interface. If SSH or the ESXi Shell is enabled, access might be possible.

Strict-Mode: The host can only be accessed through vCenter Server. If SSH or the ESXi Shell is enabled, running sessions for accounts in the DCUI.Access advanced option and for Exception User accounts that have administrator privileges remain enabled. All other sessions are closed.

- Browse to the host in the vSphere Client inventory.
- Click Configure.
- Under System, select Security Profile.
- In the Lockdown Mode panel, click Edit.
- Click Lockdown Mode and select one of the lockdown mode options.
- Click OK.

### Certificates

Upload a Certificate: https://www.filecloud.com/blog/2022/06/installing-an-ssl-certificate-on-an-esxi-server/
Use a Self-Signed Certificate: https://www.starwindsoftware.com/blog/how-to-replace-your-default-esxi-ssl-certificate-with-a-self-signed-certificate

### Shell

By default, the ESXi Shell and SSH services are not running and only the root user can log in to the Direct Console User Interface (DCUI). If you decide to enable ESXi or SSH access, you can set timeouts to limit the risk of unauthorized access. Account locking is supported for access through SSH and through the vSphere Web Services SDK. By default, a maximum of 10 failed attempts is allowed before the account is locked. The account is unlocked after two minutes by default.

#### SSH

Limit SSH access to ESXi hosts to authorized administrators only. Disable SSH access when not actively required for administrative tasks. When enabling SSH, restrict access to specific IP addresses or authorized networks. Implement SSH key-based authentication instead of password-based authentication for stronger security.

#### ESXi Shell and DCUI

ESXi Shell and Direct Console User Interface (DCUI): , which provide direct access to the ESXi host’s command line interface. Limit access to these interfaces to authorized administrators only. Disable or restrict access to the ESXi Shell and DCUI when not needed for troubleshooting or maintenance.

### Firewall

ESXi includes a firewall that is enabled by default. At installation time, the ESXi firewall is configured to block incoming and outgoing traffic, except traffic for services that are enabled in the security profile of the host. As you open ports on the firewall, consider that unrestricted access to services running on an ESXi host can expose a host to outside attacks and unauthorized access. Reduce the risk by configuring the ESXi firewall to enable access only from authorized networks.

You can manage ESXi firewall ports as follows:

- Use Configure > Firewall for each host in the vSphere Client.
- Use ESXCLI commands from the command line or in scripts

| Command                                                             | Description                                                                                                 |
| ------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| esxcli network firewall get                                         | Return the enabled or disabled status of the firewall and lists default actions.                            |
| esxcli network firewall set --default-action                        | Set to true to set the default action to pass. Set to false to set the default action to drop.              |
| esxcli network firewall set --enabled                               | Enable or disable the ESXi firewall.                                                                        |
| esxcli network firewall load                                        | Load the firewall module and the rule set configuration files.                                              |
| esxcli network firewall refresh                                     | Refresh the firewall configuration by reading the rule set files if the firewall module is loaded.          |
| esxcli network firewall unload                                      | Destroy filters and unload the firewall module.                                                             |
| esxcli network firewall ruleset list                                | List rule sets information.                                                                                 |
| esxcli network firewall ruleset set --allowed-all                   | Set to true to allow all access to all IPs. Set to false to use a list of allowed IP addresses.             |
| esxcli network firewall ruleset set --enabled --ruleset-id=<string> | Set enabled to true to enable the specified ruleset. Set enabled to false to disable the specified ruleset. |
| esxcli network firewall ruleset allowedip list                      | List the allowed IP addresses of the specified rule set.                                                    |
| esxcli network firewall ruleset allowedip add                       | Allow access to the rule set from the specified IP address or range of IP addresses.                        |
| esxcli network firewall ruleset allowedip remove                    | Remove access to the rule set from the specified IP address or range of IP addresses.                       |
| esxcli network firewall ruleset rule list                           | List the rules of each ruleset in the firewall.                                                             |

#### Firewall-Ruleset for ESXi-Free-Edition

```bash
# Enable SSH/SCP outgoing on ESXi:
esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true
```

```bash
# Disable unlicensed/unneeded services:
esxcli network firewall ruleset set --ruleset-id vMotion --enabled=false
esxcli network firewall ruleset set --ruleset-id faultTolerance --enabled=false
esxcli network firewall ruleset set --ruleset-id rabbitmqproxy --enabled=false
esxcli network firewall ruleset set --ruleset-id WOL --enabled=false
esxcli network firewall ruleset set --ruleset-id NFC --enabled=false
esxcli network firewall ruleset set --ruleset-id CIMHttpServer --enabled=false
esxcli network firewall ruleset set --ruleset-id CIMHttpsServer --enabled=false
esxcli network firewall ruleset set --ruleset-id CIMSLP --enabled=false
esxcli network firewall ruleset set --ruleset-id vpxHeartbeats --enabled=false
esxcli network firewall ruleset set --ruleset-id HBR --enabled=false
esxcli network firewall ruleset set --ruleset-id snmp --enabled=false
esxcli network firewall ruleset set --ruleset-id DVSSync --enabled=false
esxcli network firewall ruleset set --ruleset-id iofiltervp --enabled=false
```

```bash
# Limit SSH incoming:
esxcli network firewall ruleset set --allowed-all false --ruleset-id=sshServer
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.123/32 --ruleset-id=sshServer
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.0/24 --ruleset-id=sshServer
```

```bash
# Restrict access to WebUi:
esxcli network firewall ruleset set --allowed-all false --ruleset-id=webAccess
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.123/32 --ruleset-id=webAccess
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.0/24 --ruleset-id=webAccess

esxcli network firewall ruleset set --allowed-all false --ruleset-id=vSphereClient
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.123/32 --ruleset-id=vSphereClient
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.0/24 --ruleset-id=vSphereClient
```

[^4]: https://www.truesec.com/hub/blog/secure-your-vmware-esxi-hosts-against-ransomware#steps
[^5]: https://www.thomas-krenn.com/de/wiki/VMware_ESXi_updaten
[^6]: https://docs.macstadium.com/docs/update-standalone-esxi-host-via-online-bundle
[^7]: https://blog.netwrix.com/2020/01/16/vmware-security-best-practices/
[^8]: https://cloudnativejourney.wordpress.com/2023/06/07/a-comprehensive-guide-to-securing-esxi-hosts-safeguarding-virtual-infrastructure/
[^9]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-88B24613-E8F9-40D2-B838-225F5FF480FF.html#GUID-88B24613-E8F9-40D2-B838-225F5FF480FF
[^10]: https://www.starwindsoftware.com/blog/how-to-secure-a-small-vmware-environment
[^11]: https://www.starwindsoftware.com/blog/securing-vmware-esxi-hosts
[^12]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-E9B71B85-FBA3-447C-8A60-DEE2AE1A405A.html
[^13]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-7A8BEFC8-BF86-49B5-AE2D-E400AAD81BA3.html

## Setup [^14]

Open your web browser and enter the IP address of your VMware vSphere Client. Enter your user name in the domain\username format and then enter your password. You can use an administrative account or another account that has enough permissions to create virtual machines in vCenter. Click Login.

![Screenshot-1](./assets/vm_create_01.webp)

Once you have logged in to vCenter 7, click Hosts and Clusters, select your data center, and click the ESXi host on which you want to create a new virtual machine. Click Actions > New virtual machine to start creating a new VM on the selected ESXi host by using VMware vSphere Client.

![Screenshot-2](./assets/vm_create_02.webp)

### The VM Wizard

1. Select a creation type. Click Create a new virtual machine because you need to create a new VM from scratch. If you need to clone a VM or deploy a VM from a template, choose one of the other options. Click Next at each step to continue.

![Screenshot-3](./assets/vm_create_03.webp)

2. Select a name and folder. Enter a name for the new virtual machine. Then select a location for the virtual machine. We will store the new VM in the QA data center.

![Screenshot-4](./assets/vm_create_04.webp)

3. Select a compute resource. Select the ESXi host to run a new virtual machine. As we want to create a new VM on the ESXi host with IP address 10.10.20.86, we select this host in the list. Compatibility checks succeeded means that everything is correct and you can continue.

![Screenshot-5](./assets/vm_create_05.webp)

4. Select storage. Select a datastore where the virtual machine files, including the virtual disk files, will be stored. Make sure that there is enough free space on the selected datastore. In this example, the 86-HDD-R1 datastore is selected.

![Screenshot-6](./assets/vm_create_06.webp)

5. Select compatibility. Select compatibility for this virtual machine depending on the ESXi hosts used in your environment. VMware vCenter 7.0 can be configured to manage ESXi 7.0, ESXi 6.7 and ESXi 6.5 hosts. The ESXi compatibility level defines the virtual machine hardware version. The ESXi 7.0 compatibility level is used for the VM hardware version 17 and supports all vSphere 7 features.

The available options are:

- Hardware version 16 – VMware Workstation 15 and ESXi 7.0
- Hardware version 15 – ESXi 6.7 U2 and later
- Hardware version 14 – ESXi 6.7 and later
- Hardware version 13 – ESXi 6.5 and later

![Screenshot-7](./assets/vm_create_07.webp)

6. Select a guest OS. Select a guest OS family and then select a guest OS version. Selecting the correct guest OS in the list allows the wizard to provide the suitable default configuration of the VM for installing an operating system on the VM.

![Screenshot-8](./assets/vm_create_08.webp)

7. Customize hardware. Configure virtual hardware for the virtual machine. Click the type of hardware to expand settings. In most cases, you can leave the default settings except for:

- CPU: select the number of processors and CPU cores.
- Memory: define the amount of RAM.
- Harddisk: select the size of a virtual hard disk and the provisioning type.
- Network: select the network to which a virtual network adapter of the VM must be connected.
- CD/DVD Drive: You need to configure a CD/DVD drive to boot from the operating system installation media and install the operating system. There are multiple options.
  - Client Device – an optical disc inserted into a CD/DVD drive on a client machine is used to boot the operating system installer. You need to insert an optical medium into the DVD-ROM of the computer on which you’re using VMware vSphere Client.
  - Datastore ISO File. Upload an ISO image of the installation disc to the datastore attached to the ESXi host on which you are creating a new VM and are going to install an operating system. Then select the ISO file uploaded on the datastore.
  - Content Library ISO File. Select the needed ISO image file from the Content Library. You should upload the ISO file to the Content Library before you can select the image.

![Screenshot-9](./assets/vm_create_09.webp)

8. Ready to complete. Check configuration for your new VM and hit Finish to create the new VM.

#### Harddisk: Controller [^15]

ESXi offers several disk controllers to choose from in the virtual hardware, depending on the version of the hypervisor and the guest system. Overall, ESXi supports the BusLogic Parallel, LSI Logic Parallel, LSI Logic SAS and VMware Paravirtual controllers in the guest system for the SCSI controllers as well as AHCI, SATA and NVMe controllers.

![Screenshot-10](./assets/vm_create_10.png)

- The LSI Logic Parallel driver (formerly known as LSI Logic), on the other hand, supports a queue depth of 32 on most guest operating systems. That's why it was often preferred in the past, even when not every guest system included this driver.
- The LSI Logic SAS is a further development of the parallel driver and has gained enormous importance because it is required for Microsoft Cluster Services from Windows 2008 onwards and is therefore now on board in almost all current guest systems.
- VMware Paravirtual (PVSCSI) is designed to enable very high throughput with minimal processing costs. It is therefore the most efficient driver to date. The performance decision is therefore reduced to LSI Logic SAS versus VMware Paravirtual.
- For Windows from 8.1 and Server 2012 as well as for Linux distributions with a 4-kernel, the choice is reduced to LSI-Logic SAS and VMware Paravirtual (PVSCSI).

![Screenshot-11](./assets/vm_create_11.png)

#### Harddisk: Provision Types [^16] [^17]

When creating a new virtual hard disk, it is possible to configure disk provisioning. The three options “Thick-Provision Lazy-Zeroed”, “Thick-Provision Eager-Zeroed” and “Thin Provision” are available here.

**Thick Provisioning**

Thick provisioning is a type of storage pre-allocation. With thick provisioning, the complete amount of virtual disk storage capacity is pre-allocated on the physical storage when the virtual disk is created. A thick-provisioned virtual disk consumes all the space allocated to it in the datastore right from the start, so the space is unavailable for use by other virtual machines. There are two sub-types of thick-provisioned virtual disks:

- A Lazy zeroed disk is a disk that takes all of its space at the time of its creation, but this space may contain some old data on the physical media. This old data is not erased or written over, so it needs to be “zeroed out” before new data can be written to the blocks. This type of disk can be created more quickly, but its performance will be lower for the first writes due to the increased IOPS (input/output operations per second) for new blocks;
- An Eager zeroed disk is a disk that gets all of the required space still at the time of its creation, and the space is wiped clean of any previous data on the physical media. Creating eager zeroed disks takes longer, because zeroes are written to the entire disk, but their performance is faster during the first writes. This sub-type of thick-provisioned virtual disk supports clustering features, such as fault tolerance.

![Screenshot-12](./assets/vm_create_12.webp)

For data security reasons, eager zeroing is more common than lazy zeroing with thick-provisioned virtual disks. Why? When you delete a VMDK, the data on the datastore is not totally erased; the blocks are simply marked as available, until the operating system overwrites them. If you create an eager zeroed virtual disk on this datastore, the disk area will be totally erased (i.e., zeroed), thus preventing anyone with bad intentions from being able to recover the previous data – even if they use specialized third-party software.

**Thin Provisioning**

Thin provisioning is another type of storage pre-allocation. A thin-provisioned virtual disk consumes only the space that it needs initially, and grows with time according to demand. For example, if you create a new thin-provisioned 30GB virtual disk and copy 10 GB of files to it, the size of the resulting VMDK file will be 10 GB, whereas you would have a 30GB VMDK file if you had chosen to use a thick-provisioned disk.

![Screenshot-13](./assets/vm_create_13.webp)

Thin-provisioned virtual disks are quick to create and useful for saving storage space. The performance of a thin-provisioned disk is not higher than that of a lazy zeroed thick-provisioned disk, because for both of these disk types, zeroes have to be written before writing data to a new block. Note that when you delete your data from a thin-provisioned virtual disk, the disk size is not reduced automatically. This is because the operating system deletes only the indexes from the file table that refer to the file body in the file system; it marks the blocks that belonged to “deleted” files as free and accessible for new data to be written onto. This is why we see file removal as instant. If it were a full deletion, where zeroes were written over the blocks that the deleted files occupied, it would take about the same amount of time as copying the files in question.

### Best Practices (possibly outdated) [^18]

**1. Set the most important settings using the vSphere Client**

The “Configuration” tab is particularly interesting when a host is clicked in the client. There you can see numerous links on the left that can be used to adjust the host settings. Using the “Processors” menu item in the right area you can see how many sockets are installed in the server. This way, for example, it can be determined whether enough licenses are used for the vSphere hosts. Companies require a vSphere license for each processor. So if a vSphere host with four processors is used, then four licenses are required for this host.

**2. Hardware-Assisted CPU Virtualization – VT-x and AMD-V enable**

Small companies in particular often fail to activate the processor's virtualization functions. It is even more problematic when servers are used that are not enabled for virtualization. Therefore, only servers that support Intel VT-x or AMD-V should be used. Current Intel processors are superior to AMD processors in terms of performance. The virtualization functions of Intel processors can usually be activated via the BIOS/EFI. There is no need to configure this technology. Once activated, it will be available.

If Intel VT-x is disabled on servers, virtualization solutions such as VMware vSphere 6 will no longer function optimally. For example, if VMs are to be moved between different hosts during operation, the CPU must support this. Since multiple operating systems run in parallel on a server with virtualization, outdated processors are not suitable. Especially when it comes to so-called ring-0 requests, the hypervisor has to intervene and rewrite the requests to the CPU. These processes are time-consuming and significantly slow down performance. Therefore, the virtualization features are important. You can also check whether the processor supports this function using the free CPU-Z tool.

**3. Hardware BIOS Settings – Power Management and Turbo Mode**

In addition to activating the virtualization functions, other settings should be made in the server's BIOS so that ESXi functions optimally. It is particularly important to set that power management is carried out by the operating system. This can also often be found as “OS Controlled Mode”. This ensures that ESXi itself can use power management. Turbo mode in the BIOS should also be activated. If there is an option “C1E” in the BIOS, this should also be activated. This power saving feature is also supported by ESXi and is necessary for power management.

**4. Pay attention to general settings for VMs – protect guest operating systems**

The first step in optimizing VMs is to correctly set permissions and roles in the vSphere infrastructure. It should be ensured that only the administrators who need this access have access to the VMs. If you want to prevent vSphere administrators from accessing the guest operating systems, a new role should be created and the “Guest Operations” privilege should be revoked. This prevents vSphere administrators from making administrative changes within the guest operating systems. The setting can be found via “All Rights\Virtual Machine\Guest Operations”.

**5. Remove unnecessary hardware**

In general, any virtual hardware that is not necessary for a VM should be removed if possible. Serial interfaces or other outdated hardware in particular place a strain on the performance of the host and may also cause security gaps. But it's not just serial interfaces that cause problems, but also the connection of physical CD/DVD drives. If a virtual server no longer requires access to a specific ISO file or physical drive, then that connection should be severed.

**6. Use the right network adapters – E1000 or VMXNET**

When configuring the virtual machines, you can also specify how many virtual network adapters are assigned to the VM and which virtual networks should be used. The virtual networks that were previously configured in vCenter or the vSphere Client are also displayed here. The type of virtual network adapter is also specified here. The most compatible card is the E1000, but it does not offer the performance of the two adapters VMXNET 2 and 3. If the virtual operating system supports these current adapters, they should also be used. These two types of adapters are paravirtualized and therefore significantly more powerful in most cases.

Older operating systems use E1000 adapters. However, if companies rely on current operating systems, for example Windows Server 2008 R2/2012/2012 R2 or Windows Server 2016, VMXNET 3 adapters should be used. In addition to the performance advantages mentioned, these also have current network functions such as jumbo frames and more. Unlike E1000 adapters, using VMXNET adapters requires ensuring that VMware tools are installed in the VM. In addition, the VM must be installed as hardware version 7 or newer.

**7. Choose optimal SCSI adapters**

When creating a new VM, you can also specify the desired SCSI adapter on which the virtual hard drives will be operated. BusLogic is particularly suitable for older guest operating systems. The LSI adapters offer better performance for current operating systems. Various options are available here.

The SAS option (Serial Attached Storage) is available from hardware version 7. This adapter is primarily used when current Windows servers starting from Windows Server 2008 R2 are virtualized. Administrators will later also have the option of downloading the appropriate drivers directly from the LSI Logic website. Paravirtual adapters offer significantly higher throughput. These adapters are primarily used when a fast storage system, such as a SAN, is used. However, such adapters should only be used as additional adapters, specifically for access to the fast storage system.

**8. Set hard drive formats correctly**

When creating a new virtual hard disk, it is possible to configure disk provisioning. The three options “Thick-Provision Lazy-Zeroed”, “Thick-Provision Eager-Zeroed” and “Thin Provision” are available here.

If the “Thin Provision” option is selected, the virtual hard drive is only provided with as much space as it currently needs. If the virtual hard drive requires more memory, this will be provided gradually. Of course, the performance of the VM suffers as a result.

The Thick-Provision Lazy-Zeroed format is the standard format for new virtual disks. This selection will automatically set the virtual disk files to the size that corresponds to the size of the virtual disk. This means that the size of the virtual hard drive does not have to grow, which results in significantly better performance.

The third option “Thick-Provision Eager-Zeroed” is mainly selected if the VM is to be mirrored (Fault Tolerance, FT). With this option, the reserved areas of the hard drive are automatically filled with zeros. Therefore, creating this virtual hard drive takes longer than the other two versions. This type of virtual hard drive is also required for a virtual Windows cluster, for example.

**9. Pay attention to the order when updating**

To upgrade an entire environment to vSphere 6, administrators should first update the vSphere Client that they use to manage the environment. The vCenter servers should then be updated and only then the individual hosts. The new vSphere Client can also be used to manage older vSphere environments.

Before updating, you should make sure that the hardware of the individual servers is compatible with the new version. In addition, the license numbers may have to be re-entered after the update. A direct upgrade is only possible from vSphere 5 to vSphere 6. If the vCenter Server has been updated, care should also be taken to update other components before updating the hosts.

**10. Update virtual servers**

If companies have updated their hosts to vSphere 6.0, it may make sense to set the hardware version of the virtual servers to the new version 11. However, before virtual servers are upgraded to hardware version 11, the VMware tools on the virtual servers must be updated.

**11. The use of snapshots**

Snapshots can never be grouped. When a snapshot is restored, all of the VM's data captured in the snapshot is always restored. If administrators want to back up different states of a VM, they have to create different snapshots. A snapshot not only backs up the virtual hard drives, but also the VM's configuration file.
When a snapshot is created for a database server or an Active Directory domain controller, the snapshot also captures the state of the database and Active Directory. Restoring such a snapshot may cause problems with the database or the Active Directory database. It becomes particularly problematic when the database servers or virtual domain controllers replicate with other domain controls and synchronize stale data from the snapshot to these servers. It may therefore be necessary for such virtual servers to be disconnected from the network first and only then to restore the snapshot.

**12. Keep ESXi hosts up to date**

VMware regularly releases updates for vSphere. These updates can either be installed via the update manager or installed manually on the individual hosts. This makes sense, for example, if no vCenter is in use. Manually updating vSphere hosts is particularly useful if only a manageable number of hosts are in use or only individual servers in a test environment need to be updated. As soon as VMware makes updates for vSphere available, they can be found in the VMware download portal.

### Hostname & Certificates [^19]

#### Set Hostname and FQDN via SSH

```bash
esxcli system hostname set --host=NEWHOSTNAMEHERE
esxcli system hostname set --fqdn=NEWHOSTNAMEHERE.domain.name
```

#### Managing Certificates by Using the VMware Host Client [^20]

- Click Manage in the VMware Host Client inventory and click Security & Users.
- Click Certificates and click Import new certificate.
- Generate a certificate signing request:
  - Generate FQDN signing request
  - Generate IP signing request

[^14]: https://www.nakivo.com/blog/how-to-create-a-virtual-machine-using-vsphere-client-7/
[^15]: https://www.windowspro.de/thomas-drilling/virtuelle-disk-controller-fuer-vms-esxi-lsi-logic-sas-vmware-paravirtual
[^16]: https://www.nakivo.com/blog/thick-and-thin-provisioning-difference/
[^17]: https://www.starwindsoftware.com/blog/vmware-esxi-disk-provision-work-difference-one-better
[^18]: https://www.ip-insider.de/12-vmware-best-practices-a-722ae61d5e26bfac199075a4696f82eb/
[^19]: https://kb.vmware.com/s/article/1010821
[^20]: https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-esxi-host-client/GUID-42AAE815-90CF-4D13-A01C-596A345A33DE.html
