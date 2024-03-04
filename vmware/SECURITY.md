# How To - VMware - Security

> **Note:**
> The ESXi hypervisor is secured out of the box. You can further protect ESXi hosts by using lockdown mode and other built-in features. For consistency, you can set up a reference host and keep all hosts in sync with the host profile of the reference host. You can also protect your environment by performing scripted management, which ensures that changes apply to all hosts. You can enhance protection of ESXi hosts that are managed by vCenter Server with the following actions. See the Security of the VMware vSphere Hypervisor white paper for background and details.

## TPM 2.0 [^1]

```
TPM 2.0 is a hardware chip that most modern physical servers have. It allows the operating system (ESXi in our case) to store secrets, keys, measurements etc. in a secure manner. This is used by vCenter Server to make sure the ESXi hosts’ boot files haven’t been tampered with, and works with vSphere/ESXi 6.7 and newer.

For the vSphere Attestation, there isn’t any specific configuration that needs to be set. If your ESXi hosts have active TPM 2.0 chips, vCenter Server will automatically display their attestation status in the ‘Monitor->Security’ tab of the clusters.

In vSphere 7.0 U2 and newer, the TPM 2.0 chip is also used to encrypt the configuration of the ESXi host as well as protect some settings from tampering (called ‘enforcement’). 
```

![Screenshot-1](/files/vmware_secure_1.png)

## Secure Boot [^1]

```
Secure Boot is a UEFI BIOS feature that strengthens the security of the operating system (ESXi in this case) by making sure that all code that is loaded at boot is digitally signed and has not been tampered with. It also adds the benefit of disallowing threat actors from circumventing your set VIB ‘Acceptance level’ by them simply adding ‘–force’ at the end of the installation command.

However, there might be some installation packages (‘VIBs’, in vSphere language) that are not approved/signed by VMware or partners. These will then have the wrong ‘Acceptance level’ and can prevent Secure Boot from working correctly. To check if your ESXi host already has Secure Boot enabled, and whether there are any obstacles to enabling it, run the following two commands from an ESXi command line (SSH or ESXi Shell):
```

- /usr/lib/vmware/secureboot/bin/secureBoot.py -s
- /usr/lib/vmware/secureboot/bin/secureBoot.py -c

```
In vSphere 7.0 U2, the Secure Boot setting can be protected from tampering using the ‘enforcement’ capability. This is set using the following command line:
```

- [root@localhost:~] esxcli system settings encryption set --require-secure-boot=TRUE

## execInstalledOnly [^1]

```
The execInstalledOnly setting prohibits execution of custom code inside ESXi and will make the ESXi host simply refuse to execute anything that was not installed through a signed VIB package from a certified partner.

The setting is found in ESXi under Manage->Advanced Settings at VMkernel.Boot.execInstalledOnly and it can be set without having to open a CLI to each ESXi host. We can set it for individual ESXi hosts using the vSphere Web Client or for multiple ESXi hosts at a time using PowerCLI

The default setting of an ESXi host is that execInstalledOnly is set to FALSE. We can verify this by simply listing the setting using:
```

- [root@localhost:~] esxcli system settings kernel list -o execinstalledonly

```
Now, we set the execInstalledOnly setting to TRUE using:
```

- [root@localhost:~] esxcli system settings kernel set -s execinstalledonly -v TRUE

```
In vSphere 7.0 U2, the execInstalledOnly setting can be protected from tampering using the ‘enforcement’ capability. This is set using the following command line:
```

- [root@localhost:~] esxcli system settings encryption set –require-exec-installed-only=TRUE

### Patching with execInstalledOnly [^1]

```
If you are updating/patching ESXi hosts using vSphere Lifecycle Manager (formerly known as Update Manager) using the old fashioned Baseline method rather than the newer Image method you will bump into problems when having execInstalledOnly set to TRUE.

The recommended workaround is to switch to the Image method, since it will also bring other benefits. If you can’t switch, you will unfortunately need to wait until vSphere 8.0 before being able to enable execInstalledOnly.

When using the baseline method and enabling execInstalledOnly, the error message you will get when scanning an ESXi host for patch compliance is: "Cannot deploy host upgrade agent. Ensure that vSphere Lifecycle Manager is officially signed. Check the network connectivity and logs of host agent and vpxa for details."
```

## Updates/Patches

```
Keep your ESXi hosts up to date with the latest security patches and updates. Regularly check for vendor-provided patches and apply them promptly to address any known vulnerabilities.
```

> **Check VIB package integrity:**
> Each VIB package has an associated acceptance level. You can add a VIB to an ESXi host only if the VIB acceptance level is the same or better than the acceptance level of the host. 
> You cannot add a CommunitySupported or PartnerSupported VIB to a host unless you explicitly change the host's acceptance level.

### Offline Bundle via Command Line [^2]

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

### Online Bundle via Command Line [^3]
- Log into the host via SSH. You can use putty, the terminal, or your favorite SSH client.
- Stop or migrate all virtual machines, and then put the host in maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e true
- Check maintenance mode: [root@localhost:~] esxcli system maintenanceMode get
- Check the profile version you are running: [root@localhost:~] esxcli software profile get
- Enable the host firewall rule to allow web traffic: [root@localhost:~] esxcli network firewall ruleset set -e true -r httpClient
- List the online depot profiles available to you: [root@localhost:~] esxcli software sources profile list -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml | grep -i ESXi-6
- Select the package you want to install and insert it into the command: [root@localhost:~] esxcli software profile update -p PACKAGE-NAME -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml
- Now perform a reboot: [root@localhost:~] esxcli system shutdown reboot -r "Update ESXi"
- After the reboot, exit maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e false

### vSphere Update Manager (VUM)

Check: https://core.vmware.com/resource/vsphere-update-manager#section1

> **Renamed:**
> vSphere Update Manager (VUM) to vSphere Lifecycle Manager (VLCM)

### vSphere Lifecycle Manager (VLCM)

Check: https://cherrypicking.dev/update-esxi-hosts-using-lifecycle-manager/

## Accounts, Passwords and Role Management (RBAC)

```

```

## Encryption

```

```

## Lockdown Mode

```

```

## Certificates

```

```

## SSH

```

```

## Firewall

```

```

## Automation and Centralized Management

```

```

## Monitoring

```

```















[^1]: https://www.truesec.com/hub/blog/secure-your-vmware-esxi-hosts-against-ransomware#steps
[^2]: https://www.thomas-krenn.com/de/wiki/VMware_ESXi_updaten
[^3]: https://docs.macstadium.com/docs/update-standalone-esxi-host-via-online-bundle