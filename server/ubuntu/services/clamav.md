# ClamAV [^1] [^2]

## Installation

```bash
sudo apt install clamav
```

## Updates

```bash
sudo freshclam
```

## Scanning Folders (manually)

```bash
sudo clamscan -r /path
```

Use Switches

```
ClamAV has a number of switches that can be used to customize its behavior. Some of the most useful switches are:

The –infected switch tells ClamAV to only report infected files. This is useful if you only want to know which files are infected, and you don’t want to remove them.
–infected

The –remove switch tells ClamAV to remove infected files. This is the default behavior, so you don’t need to use this switch unless you want to override the default behavior.
–remove

The –recursive switch tells ClamAV to scan a directory and all of its subdirectories. This is useful for scanning large directories or directories that may contain infected files.
–recursive
```

## Scanning Folders (automatically)

```bash
sudo nano /etc/clamav/clamd.conf
```

```
You can set ClamAV to scan automatically at regular intervals. This is a good way to ensure that your system is always protected from viruses.
To set ClamAV to scan automatically, open the ClamAV configuration file.
Find the ScanInterval directive.
```

```bash
sudo service clamav-freshclam restart
```

[^1]: https://www.webhi.com/how-to/setup-config-clamav-on-ubuntu-debian/
[^2]: https://manpages.ubuntu.com/manpages/focal/en/man5/clamd.conf.5.html
