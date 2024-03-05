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
- Select the package you want to install and insert it into the command: [root@localhost:~] esxcli software profile update -p PACKAGE-NAME -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml (ESXi 7 Example: esxcli software profile update -p ESXi-7.0U3o-22348816-standard \ -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml)
- Now perform a reboot: [root@localhost:~] esxcli system shutdown reboot -r "Update ESXi"
- After the reboot, disable the host firewall rule to allow web traffic: [root@localhost:~] esxcli network firewall ruleset set -e false -r httpClient
- After the reboot, exit maintenance mode: [root@localhost:~] esxcli system maintenanceMode set -e false

### vSphere Update Manager (VUM)

Check: https://core.vmware.com/resource/vsphere-update-manager#section1

> **Renamed:**
> vSphere Update Manager (VUM) to vSphere Lifecycle Manager (VLCM)

### vSphere Lifecycle Manager (VLCM)

Check: https://cherrypicking.dev/update-esxi-hosts-using-lifecycle-manager/

## Accounts, Passwords and Role Management (RBAC)

- Role-Based Access Control (RBAC): Utilize RBAC to define and assign roles with specific privileges and permissions to users and groups. Regularly review and update role assignments to align with organizational changes.
- Secure Password Policies: Enforce strong password policies for ESXi host access. Set password complexity requirements, such as minimum length, character combinations, and expiration periods.
- Two-Factor Authentication (2FA): Implement 2FA to add an extra layer of security to ESXi host access. This requires users to provide a second form of authentication, typically a one-time password or a token, in addition to their regular credentials. 2FA significantly strengthens access controls by reducing the risk of unauthorized access in case of password compromise.

### ESXi Passwords

```
ESXi uses the Linux PAM module pam_passwdqc for password management and control. We can change the required length, character class requirement, or allow pass phrases using the ESXi Advanced setting Security.PasswordQualityControl.

retry=3 min=disabled,disabled,disabled,7,7

What does these placeholders mean?
```

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

![Screenshot-2](/files/vmware_secure_2.webp)

### ESXi Passphrase

```
Instead of a password, you can also use a pass phrase. However, pass phrases are disabled by default. You can change the default setting and other settings by using the Security.PasswordQualityControl advanced option from the vSphere Client. 

retry=3 min=disabled,disabled,16,7,7

This example allows pass phrases of at least 16 characters and at least three words.
```

## Encryption

```
Secure Encrypted Virtualization (SEV): If using AMD processors that support SEV, enable this feature to encrypt virtual machine memory, isolating it from other virtual machines and the hypervisor. SEV provides an additional layer of protection against memory-based attacks and unauthorized access to virtual machine data.

Encrypted vMotion: Enable Encrypted vMotion to encrypt data transferred between ESXi hosts during live migrations. Encrypted vMotion protects against eavesdropping and data interception, ensuring the confidentiality and integrity of virtual machine data during migrations.

Secure Communication Protocols: Utilize secure communication protocols to protect data transmitted over the management network. Enable and enforce Secure Socket Layer (SSL)/Transport Layer Security (TLS) encryption for management interfaces, such as vSphere Web Client or vSphere Client. This ensures that communications between clients and ESXi hosts are encrypted and secure. Avoid using unencrypted protocols like HTTP or Telnet for management purposes.
```

## Lockdown Mode [^6] [^8]

```
In lockdown mode, ESXi hosts can be accessed only through vCenter Server by default. You can select strict lockdown mode or normal lockdown mode. You can define Exception Users to allow direct access to service accounts such as backup agents. 

Normal-Mode: The host can be accessed through vCenter Server. Only users who are on the Exception Users list and have administrator privileges can log in to the Direct Console User Interface. If SSH or the ESXi Shell is enabled, access might be possible.

Strict-Mode: The host can only be accessed through vCenter Server. If SSH or the ESXi Shell is enabled, running sessions for accounts in the DCUI.Access advanced option and for Exception User accounts that have administrator privileges remain enabled. All other sessions are closed.
```

- Browse to the host in the vSphere Client inventory.
- Click Configure.
- Under System, select Security Profile.
- In the Lockdown Mode panel, click Edit.
- Click Lockdown Mode and select one of the lockdown mode options.
- Click OK.

## Certificates

```
Upload a Certificate: https://www.filecloud.com/blog/2022/06/installing-an-ssl-certificate-on-an-esxi-server/

Use a Self-Signed Certificate: https://www.starwindsoftware.com/blog/how-to-replace-your-default-esxi-ssl-certificate-with-a-self-signed-certificate
```

## Shell

```
By default, the ESXi Shell and SSH services are not running and only the root user can log in to the Direct Console User Interface (DCUI). If you decide to enable ESXi or SSH access, you can set timeouts to limit the risk of unauthorized access. Account locking is supported for access through SSH and through the vSphere Web Services SDK. By default, a maximum of 10 failed attempts is allowed before the account is locked. The account is unlocked after two minutes by default.
```

### SSH

```
Limit SSH access to ESXi hosts to authorized administrators only. Disable SSH access when not actively required for administrative tasks. When enabling SSH, restrict access to specific IP addresses or authorized networks. Implement SSH key-based authentication instead of password-based authentication for stronger security.
```

### ESXi Shell and DCUI

```
ESXi Shell and Direct Console User Interface (DCUI): , which provide direct access to the ESXi host’s command line interface. Limit access to these interfaces to authorized administrators only. Disable or restrict access to the ESXi Shell and DCUI when not needed for troubleshooting or maintenance.
```

## Firewall

```
ESXi includes a firewall that is enabled by default. At installation time, the ESXi firewall is configured to block incoming and outgoing traffic, except traffic for services that are enabled in the security profile of the host. As you open ports on the firewall, consider that unrestricted access to services running on an ESXi host can expose a host to outside attacks and unauthorized access. Reduce the risk by configuring the ESXi firewall to enable access only from authorized networks. 

You can manage ESXi firewall ports as follows:
- Use Configure > Firewall for each host in the vSphere Client.
- Use ESXCLI commands from the command line or in scripts
```

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

### Firewall-Ruleset for ESXi-Free-Edition

```
# Enable SSH/SCP outgoing on ESXi:

esxcli network firewall ruleset set --ruleset-id sshClient --enabled=true
```

```
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

```
# Limit SSH incoming:

esxcli network firewall ruleset set --allowed-all false --ruleset-id=sshServer
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.123/32 --ruleset-id=sshServer
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.0/24 --ruleset-id=sshServer
```

```
# Restrict access to WebUi:

esxcli network firewall ruleset set --allowed-all false --ruleset-id=webAccess
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.123/32 --ruleset-id=webAccess
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.0/24 --ruleset-id=webAccess

esxcli network firewall ruleset set --allowed-all false --ruleset-id=vSphereClient
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.123/32 --ruleset-id=vSphereClient
esxcli network firewall ruleset allowedip add --ip-address=192.168.1.0/24 --ruleset-id=vSphereClient
```

[^1]: https://www.truesec.com/hub/blog/secure-your-vmware-esxi-hosts-against-ransomware#steps
[^2]: https://www.thomas-krenn.com/de/wiki/VMware_ESXi_updaten
[^3]: https://docs.macstadium.com/docs/update-standalone-esxi-host-via-online-bundle
[^4]: https://blog.netwrix.com/2020/01/16/vmware-security-best-practices/
[^5]: https://cloudnativejourney.wordpress.com/2023/06/07/a-comprehensive-guide-to-securing-esxi-hosts-safeguarding-virtual-infrastructure/
[^6]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-88B24613-E8F9-40D2-B838-225F5FF480FF.html#GUID-88B24613-E8F9-40D2-B838-225F5FF480FF
[^7]: https://www.starwindsoftware.com/blog/how-to-secure-a-small-vmware-environment
[^8]: https://www.starwindsoftware.com/blog/securing-vmware-esxi-hosts
[^9]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-E9B71B85-FBA3-447C-8A60-DEE2AE1A405A.html
[^10]: https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-7A8BEFC8-BF86-49B5-AE2D-E400AAD81BA3.html