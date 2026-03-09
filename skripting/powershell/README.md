# POWERSHELL

## Windows

### Command Overview

```powershell
# ---------------------------
# Network Configuration
# ---------------------------
ipconfig                                        # Display basic network configuration
ipconfig /all                                   # Display detailed network configuration
ipconfig /all | findstr DNS                     # Filter output to show DNS information
ipconfig /all | clip                            # Copy command output to Windows clipboard
ipconfig /release                               # Release current DHCP IP address
ipconfig /renew                                 # Request a new IP address from DHCP server
ipconfig /displaydns                            # Show DNS resolver cache
ipconfig /flushdns                              # Clear DNS resolver cache
getmac /v                                       # Display MAC addresses for network adapters

# ---------------------------
# DNS Queries
# ---------------------------
nslookup mydomain.com                           # Query DNS information for a domain
nslookup mydomain.com 8.8.8.8                   # Query a specific DNS server
nslookup -type=mx mydomain.com                  # Query specific DNS record type (MX)

# ---------------------------
# Wireless Networking
# ---------------------------
netsh wlan show wlanreport                      # Generate Wi-Fi report for last 3 days
netsh wlan show profile name="NAME" key=clear   # Show saved Wi-Fi password

# ---------------------------
# Network Interfaces
# ---------------------------
netsh interface show interface                  # Show network interfaces
netsh interface ip show address                 # Show IP address configuration
netsh interface ip show dnsservers              # Show DNS servers for interfaces

# ---------------------------
# Firewall
# ---------------------------
netsh advfirewall set allprofiles state off     # Disable Windows Defender Firewall
netsh advfirewall set allprofiles state on      # Enable Windows Defender Firewall

# ---------------------------
# Connectivity Testing
# ---------------------------
ping 8.8.8.8                                    # Ping a specific IP address
ping mydomain.com                               # Ping a domain name
ping -t mydomain.com                            # Continuous ping until stopped (Ctrl+C)
tracert mydomain.com                            # Trace route to destination
tracert -d mydomain.com                         # Faster trace without DNS resolution

# ---------------------------
# Network Monitoring & Routing
# ---------------------------
netstat                                         # Show active network connections and statistics
route print                                     # Display routing table
route add 192.168.1.0 mask 255.255.255.0 10.10.1.254   # Add route
route delete 192.168.1.0                        # Delete route

# ---------------------------
# Power / Battery Reports
# ---------------------------
powercfg /energy                                # Analyze power efficiency problems
powercfg /batteryreport                         # Generate battery usage report

# ---------------------------
# File Associations
# ---------------------------
assoc                                           # Display file type associations
assoc .mp4=VLC.vlc                              # Change file association

# ---------------------------
# Disk & System Repair
# ---------------------------
chkdsk                                          # Check disk without fixing errors
chkdsk /f                                       # Check disk and fix errors
chkdsk /r                                       # Locate bad sectors and recover data
sfc /scannow                                    # Scan and repair Windows system files
DISM /online /cleanup-image /checkhealth        # Quick check for Windows image corruption
DISM /online /cleanup-image /scanhealth         # Detailed scan for corruption
DISM /online /cleanup-image /restorehealth      # Scan and repair Windows image

# ---------------------------
# Process Management
# ---------------------------
tasklist                                        # List running processes
taskkill /f /pid 123456                         # Force kill process by PID

# ---------------------------
# System Power Control
# ---------------------------
shutdown /s /t 0                                # Shut down immediately
shutdown /s /t 60                               # Shut down after 60 seconds
shutdown /r /fw /f /t 0                         # Restart and enter BIOS/UEFI

# ---------------------------
# File Hiding / Encryption
# ---------------------------
cipher /e                                       # Encrypt files/folders
cipher /d                                       # Decrypt files/folders
attrib +h +s +r myfolder                        # Hide folder (hidden, system, read-only)
attrib -h -s -r myfolder                        # Unhide folder

# ---------------------------
# Data Hiding Trick
# ---------------------------
copy picture.jpg+secret.zip secret.jpg          # Hide zip archive inside a JPG file

# ---------------------------
# System Information
# ---------------------------
systeminfo                                      # Display detailed system information
hostname                                        # Display computer hostname
ver                                             # Display Windows version

# ---------------------------
# File System Navigation
# ---------------------------
dir                                             # List files and directories
cd                                              # Change directory
mkdir                                           # Create new directory

# ---------------------------
# File Viewing & Output
# ---------------------------
echo                                            # Print text to the console
>                                               # Redirect output to a file
type                                            # Display file contents

# ---------------------------
# File Management
# ---------------------------
copy                                            # Copy files
move                                            # Move files or directories
ren                                             # Rename files or directories
tree                                            # Display directory structure
rmdir                                           # Remove a directory
del                                             # Delete files

# ---------------------------
# Terminal Control
# ---------------------------
cls                                             # Clear the screen
```


```powershell
# ---------------------------
# Help & Discovery
# ---------------------------
Get-Help Get-Process                            # Show help for a command
Get-Help Get-Process -Examples                  # Show usage examples
Get-Command                                     # List all available commands
Get-Command *process*                           # Search commands by name
Get-Member                                      # Show properties and methods of objects

# ---------------------------
# File System Navigation
# ---------------------------
Get-Location                                    # Show current directory
Set-Location C:\Users                           # Change directory
Get-ChildItem                                   # List files and folders (like ls/dir)
Get-ChildItem -Recurse                          # List files recursively
New-Item file.txt                               # Create new file
New-Item folder -ItemType Directory             # Create directory
Remove-Item file.txt                            # Delete file
Copy-Item file.txt backup.txt                   # Copy file
Move-Item file.txt archive\                     # Move file
Rename-Item file.txt newfile.txt                # Rename file

# ---------------------------
# File Content Handling
# ---------------------------
Get-Content file.txt                            # Display file contents
Get-Content file.txt -Tail 20                   # Show last 20 lines
Set-Content file.txt "Hello"                    # Write content to file
Add-Content file.txt "New line"                 # Append content to file
Clear-Content file.txt                          # Clear file contents

# ---------------------------
# Searching & Filtering Data
# ---------------------------
Select-String "error" log.txt                   # Search text inside file (grep equivalent)
Where-Object {$_.CPU -gt 100}                   # Filter objects
Select-Object Name,CPU                          # Select specific properties
Sort-Object CPU                                 # Sort objects
Sort-Object CPU -Descending                     # Sort descending
Measure-Object                                  # Count objects
Measure-Object -Property Length -Sum            # Sum property values

# ---------------------------
# Process Management
# ---------------------------
Get-Process                                     # List running processes
Get-Process chrome                              # Show specific process
Stop-Process -Name chrome                       # Kill process by name
Stop-Process -Id 1234                           # Kill process by PID
Start-Process notepad                           # Launch program

# ---------------------------
# Services Management
# ---------------------------
Get-Service                                     # List services
Get-Service | Where-Object Status -eq Running
Start-Service wuauserv                          # Start service
Stop-Service wuauserv                           # Stop service
Restart-Service wuauserv                        # Restart service
Set-Service wuauserv -StartupType Disabled

# ---------------------------
# System Information
# ---------------------------
Get-ComputerInfo                                # System information
Get-CimInstance Win32_OperatingSystem           # OS details
Get-CimInstance Win32_Processor                 # CPU information
Get-CimInstance Win32_LogicalDisk               # Disk information
Get-CimInstance Win32_BIOS                      # BIOS info

# ---------------------------
# Network Management
# ---------------------------
Get-NetIPConfiguration                          # Show network configuration
Get-NetIPAddress                                # List IP addresses
Get-NetAdapter                                  # Show network adapters
Get-NetTCPConnection                            # Active TCP connections
Test-Connection google.com                      # Ping host
Resolve-DnsName google.com                      # DNS lookup

# ---------------------------
# Event Logs
# ---------------------------
Get-EventLog -LogName System                    # Show system log
Get-EventLog -LogName Security -Newest 50
Get-WinEvent -LogName System                    # Modern event log query
Get-WinEvent -FilterHashtable @{LogName="System";Level=2}

# ---------------------------
# User & Security Management
# ---------------------------
Get-LocalUser                                   # List local users
New-LocalUser user1                             # Create new user
Set-LocalUser user1 -PasswordNeverExpires $true
Remove-LocalUser user1                          # Delete user
Get-LocalGroup                                  # List groups
Add-LocalGroupMember -Group Administrators -Member user1

# ---------------------------
# Package Management
# ---------------------------
Get-Package                                     # List installed packages
Find-Package vscode                             # Search package
Install-Package vscode                          # Install package
Uninstall-Package vscode                        # Remove package

# ---------------------------
# Scheduled Tasks
# ---------------------------
Get-ScheduledTask                               # List scheduled tasks
Start-ScheduledTask -TaskName Backup
Disable-ScheduledTask -TaskName Backup

# ---------------------------
# Remote Management
# ---------------------------
Enter-PSSession server01                        # Remote interactive session
Exit-PSSession                                  # Exit remote session
Invoke-Command -ComputerName server01 -ScriptBlock {Get-Process}

# ---------------------------
# Environment Variables
# ---------------------------
Get-ChildItem Env:                              # Show environment variables
$env:PATH                                       # Display PATH variable
$env:MYVAR="hello"                              # Create environment variable
```

```powershell
# ---------------------------
# Useful Admin One-Liners
# ---------------------------
Get-Process | Sort CPU -Descending | Select -First 10       # Top 10 CPU consuming processes.
Get-Service | Where Status -eq Running                      # Show running services.
Get-ChildItem -Recurse -Filter *.log                        # Find all log files.
Get-NetTCPConnection | Where State -eq Established          # Show active network connections.
```