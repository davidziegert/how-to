# Installation

# Security

## Bitlocker

BitLocker is a volume encryption technology that was first introduced in Windows Vista and Windows Server 2008. Like other Microsoft products, it also suffers from certain glitches, but many people around the globe rely on BitLocker Drive Encryption (BDE) to protect their data at rest.

### BitLocker PowerShell Module

To view the various commands offered by the BitLocker module, run the following command:

```powershell
Get-Command -Module BitLocker
```

### BitLocker Installation

This command installs BitLocker (including all subfeatures and management tools) and then restarts the server to complete the installation.

```powershell
Install-WindowsFeature BitLocker -IncludeAllSubFeature -IncludeManagementTools -Restart
```

### BitLocker Volumes

To get information about the volumes (or drives) that BitLocker drive encryption can protect on your computer, use the following command:

```powershell
Get-BitLockerVolume
```

# Backup

```

```
