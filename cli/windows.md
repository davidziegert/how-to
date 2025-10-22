```powershell
ipconfig                                        # basic network configuration information of a computer
ipconfig /all                                   # detailed network configuration information of a computer
ipconfig /all | findstr DNS                     # detailed network configuration information with specific filter
ipconfig /all | clip                            # copies the output of a command to the Windows Clipboard
ipconfig /release                               # to release the IP address
ipconfig /renew                                 # to get a new IP address from the DHCP server
ipconfig /displaydns                            # displays the contents of your computer's local Domain Name System (DNS) cache
ipconfig /flushdns                              # clears the DNS resolver cache on a Windows computer
getmac /v                                       # display the MAC addresses for each network adapter in a computer
```

```powershell
nslookup mydomain.com                           # information about domain names, their IP addresses, and to their reverse lookups
nslookup mydomain.com 8.8.8.8                   # information from a specific DNS server
nslookup -type=mx mydomain.com                  # information for a specific type of record
```

```powershell
netsh wlan show wlanreport                      # generates a detailed wireless network report for the last three days
netsh wlan show profile name="NAME" key=clear   # show the password for the specific wifi-network
netsh interface show interface                  # show all network interfaces on a computer
netsh interface ip show address                 # displays the IP, subnet mask, and default gateway for the network interfaces
netsh interface ip show dnsservers              # displays the DNS server addresses configured for the network interfaces
netsh advfirewall set allprofiles state off     # deactivate the windows defender firewall
netsh advfirewall set allprofiles state on      # activate the windows defender firewall
```

```powershell
for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @echo %j | findstr -i -v echo | netsh wlan show profiles %j key=clear
```

```powershell
ping                                            # tests network and the response time between a computer and a destination host
ping 8.8.8.8                                    # ping to ip address
ping mydomain.com                               # ping to domain name
ping -t mydomain.com                            # ping permanent not only 3 times
tracert mydomain.com                            # maps the path data, showing each route along the way
tracert -d mydomain.com                         # faster mapping without resolve domain names
netstat                                         # displays current network connections, routing tables, and protocol statistics on a computer
route print                                     # view the entire contents of the IP routing table
route add                                       # add a route to a network through a specific gateway - route add 192.168.1.0 mask 255.255.255.0 10.10.1.254
route delete                                    # delete a route to a specific network - route delete 192.168.1.0
```

```powershell
powercfg /energy                                # analyzes your system for common energy-efficiency and battery life problems
powercfg /batteryreport                         # generates a detailed battery usage report for a Windows computer
assoc                                           # view the file type associations in your system
assoc .mp4=VLC.vlc                              # change the file type associations in your system
chkdsk                                          # checks for issues on the default drive and file system without fixing 
chkdsk /f                                       # checks and fix the issues 
chkdsk /r                                       # checks for file system errors and bad sectors, fixes errors, and recover data
sfc /scannnow                                   # scans and repairs corrupted or missing Windows system files by replacing them
DISM /onoline /cleanup-image /checkhealth       # quick scan of the Windows Component Store for corruption but does not repair it
DISM /online /cleanup /scanhealth               # more detailed scan of the Windows Component Store
DISM /online /cleanup /restorehealth            # scans and repairs corrupted files
tasklist                                        # displays a list of all running tasks with their Process IDs (PID)
taskkill /f /pid 123456                         # kill one or more tasks or processes by PID or name.
```

```powershell
shutdown /s /t 0                                # shut down the computer now
shutdown /s /t 60                               # shut down the computer after 60 seconds
shutdown /r /fw /f /t 0                         # restarts the computer into the BIOS
```

```powershell
copy picture.jpg+secret.zip secret.jpg          # copies the content of a zip file into a photo file to hide them
cipher /e                                       # encrypts files in a folder 
cipher /d                                       # decrypts the selected file or director
attrib +h +s +r myfolder                        # hide a folder
attrib -h -s -r myfolder                        # reveal a folder
```

```powershell
systeminfo                                      # displays detailed configuration information about a computer and its operating system
hostname                                        # displays computer hostname
ver                                             # displays current windows version
```

```powershell
dir                                             # lists files/folders in a directory
cd                                              # navigate the file system by changing the current working directory
mkdir                                           # make a new directory
echo                                            # writes input text to standard output
>                                               # sends the output of a command to a file instead of displaying it on the screen
type                                            # displays the contents of a text file
copy                                            # duplicates one or more files from a source location to a destination
tree                                            # produces a depth-indented listing of files
ren                                             # renames files and directories
move                                            # moves files and directories from one location to another
rmdir                                           # deletes a directory
delete                                          # deletes files from the command line
cls                                             # clear the screen
```