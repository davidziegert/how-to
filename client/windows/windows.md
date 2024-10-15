# Windows 11

## Installation

https://hardware-helden.de/windows-11-ohne-internet-und-ohne-microsoft-konto-installieren
https://www.gamingdeputy.com/gr/so-entfernen-sie-das-symbol-weitere-informationen-zu-diesem-bild-unter-windows-11/
https://www.windowspage.de/tipps/024131.html
https://www.windowspage.de/tipps/022065.html
https://de.minitool.com/datentraegerverwaltung/tpm-loeschen.html

## Security

### Bitlocker

BitLocker is a volume encryption technology that was first introduced in Windows Vista and Windows Server 2008. Like other Microsoft products, it also suffers from certain glitches, but many people around the globe rely on BitLocker Drive Encryption (BDE) to protect their data at rest.

#### BitLocker PowerShell Module

To view the various commands offered by the BitLocker module, run the following command:

```powershell
Get-Command -Module BitLocker
```

#### BitLocker Installation

This command installs BitLocker (including all subfeatures and management tools) and then restarts the server to complete the installation.

```powershell
Install-WindowsFeature BitLocker -IncludeAllSubFeature -IncludeManagementTools -Restart
```

#### BitLocker Volumes

To get information about the volumes (or drives) that BitLocker drive encryption can protect on your computer, use the following command:

```powershell
Get-BitLockerVolume
```

## Backup

```

```
