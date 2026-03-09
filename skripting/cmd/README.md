# CMD

## Windows

### Command Overview

```cmd
:: ---------------------------
:: Session / Terminal Control
:: ---------------------------
exit                    :: Exit the command prompt
cls                     :: Clear the terminal screen
doskey /history         :: Display command history
doskey                  :: Create command aliases/macros

:: ---------------------------
:: Navigation
:: ---------------------------
cd                      :: Change directory
dir                     :: List directory contents
chdir                   :: Same as cd (change directory)

:: ---------------------------
:: File & Directory Management
:: ---------------------------
type nul > file.txt     :: Create an empty file
mkdir                   :: Create a directory
rmdir                   :: Remove a directory
copy                    :: Copy files
xcopy                   :: Advanced file and directory copy
move                    :: Move or rename files
del                     :: Delete files
erase                   :: Same as del
mklink                  :: Create symbolic or hard links

:: ---------------------------
:: Viewing & Editing Files
:: ---------------------------
type                    :: Display file contents
more                    :: Display paged output
notepad                 :: Open file in Notepad editor
echo                    :: Print text to the terminal

:: ---------------------------
:: File Comparison & Processing
:: ---------------------------
fc                      :: Compare two files
sort                    :: Sort text input
find                    :: Search for a text string in files
findstr                 :: Advanced text search (similar to grep)

:: ---------------------------
:: File Search & Permissions
:: ---------------------------
where                   :: Locate files in the PATH
attrib                  :: Change file attributes (hidden, read-only)
icacls                  :: Change file and folder permissions
takeown                 :: Take ownership of files/folders

:: ---------------------------
:: Compression & Archiving
:: ---------------------------
tar                     :: Create or extract archives (available in modern Windows)
compact                 :: Compress files on NTFS partitions

:: ---------------------------
:: Networking
:: ---------------------------
ping                    :: Test connectivity to a host
tracert                 :: Trace network route to a destination
ipconfig                :: Display network configuration
getmac                  :: Display MAC address
netstat                 :: Display network connections and statistics
nslookup                :: Query DNS records
curl                    :: Transfer data to/from servers (available in modern Windows)

:: ---------------------------
:: Firewall
:: ---------------------------
netsh advfirewall       :: Configure Windows Firewall

:: ---------------------------
:: User Management
:: ---------------------------
whoami                  :: Display current user
net user                :: Manage user accounts
net localgroup          :: Manage local groups
runas                   :: Run a program as another user

:: ---------------------------
:: Package / Software Management
:: ---------------------------
winget                  :: Windows package manager
choco                   :: Chocolatey package manager (if installed)

:: ---------------------------
:: System Information
:: ---------------------------
ver                     :: Display Windows version
systeminfo              :: Detailed system information
tasklist                :: Display running processes
wmic                    :: Query system information (legacy)

:: ---------------------------
:: Process Management
:: ---------------------------
tasklist                :: List running processes
taskkill                :: Terminate a process by PID or name

:: ---------------------------
:: Services
:: ---------------------------
sc query                :: Display service status
sc start                :: Start a service
sc stop                 :: Stop a service

:: ---------------------------
:: File Systems
:: ---------------------------
mountvol                :: Manage volume mount points
diskpart                :: Disk partition management tool
chkdsk                  :: Check disk for errors

:: ---------------------------
:: Help & Documentation
:: ---------------------------
help                    :: Display help for commands
command /?              :: Show help for a specific command

:: ---------------------------
:: System Power
:: ---------------------------
shutdown                :: Shut down or restart the system
shutdown /r             :: Restart the system
shutdown /s             :: Shut down the system
```