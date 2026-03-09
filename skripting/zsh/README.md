# ZSH

## macOS

### Command Overview

```zsh
# ---------------------------
# Session / Terminal Control
# ---------------------------
ssh                 # Secure Shell: connect to a remote system
exit                # Exit the current shell session
clear               # Clear the terminal display
history             # Show previously executed commands
alias               # Create command shortcuts
open                # Open files or applications from the terminal

# ---------------------------
# Navigation
# ---------------------------
pwd                 # Print the current working directory
ls                  # List directory contents
cd                  # Change directory

# ---------------------------
# File & Directory Management
# ---------------------------
touch               # Create an empty file
mkdir               # Create a directory
rmdir               # Remove an empty directory
cp                  # Copy files or directories
mv                  # Move or rename files
rm                  # Delete files or directories
ln                  # Create hard or symbolic links

# ---------------------------
# Viewing & Editing Files
# ---------------------------
cat                 # Display file contents in the terminal
less                # View file contents page by page
head                # Display the first lines of a file
tail                # Display the last lines of a file
nano                # Simple terminal text editor
vim                 # Advanced terminal text editor
echo                # Print text to the terminal or into files

# ---------------------------
# File Comparison & Processing
# ---------------------------
cmp                 # Compare two files byte by byte
diff                # Show differences between two files
comm                # Compare two sorted files
sort                # Sort lines of text files
grep                # Search text for patterns
awk                 # Pattern scanning and text processing

# ---------------------------
# File Search & Permissions
# ---------------------------
find                # Search for files and directories
chmod               # Change file permissions
chown               # Change file ownership
chgrp               # Change group ownership

# ---------------------------
# Compression & Archiving
# ---------------------------
tar                 # Create or extract archive files
zip                 # Compress files into a zip archive
unzip               # Extract zip archives
gzip                # Compress files using gzip
gunzip              # Decompress gzip files

# ---------------------------
# Networking
# ---------------------------
curl                # Transfer data to/from a server
ping                # Test connectivity to a host
traceroute          # Show the network path to a destination
ifconfig            # Display network interfaces (legacy)
netstat             # Show network connections and statistics
scutil --dns        # Display DNS configuration
ssh-keygen          # Generate SSH keys

# ---------------------------
# User Management
# ---------------------------
whoami              # Display current user
id                  # Display user and group IDs
dscl                # Directory Service command-line tool
passwd              # Change user password
sudo                # Execute commands with elevated privileges
su                  # Switch user identity

# ---------------------------
# Package Management
# ---------------------------
brew                # Homebrew package manager
port                # MacPorts package manager (if installed)

# ---------------------------
# System Information
# ---------------------------
uname               # Show system information
sw_vers             # Display macOS version
system_profiler     # Detailed hardware and system info
top                 # Show running processes
htop                # Advanced interactive process viewer (if installed)
vm_stat             # Display memory usage
df                  # Show disk space usage

# ---------------------------
# Process Management
# ---------------------------
ps                  # List running processes
top                 # Real-time process viewer
kill                # Terminate a process by PID
pkill               # Terminate processes by name
killall             # Kill processes by name

# ---------------------------
# System Services
# ---------------------------
launchctl           # Manage macOS services and daemons

# ---------------------------
# File Systems
# ---------------------------
mount               # Mount file systems
diskutil            # Disk and volume management
hdiutil             # Manage disk images (.dmg files)

# ---------------------------
# Help & Documentation
# ---------------------------
man                 # Manual pages for commands
whatis              # Short command descriptions
which               # Show the location of a command

# ---------------------------
# System Power
# ---------------------------
reboot               # Restart the system
shutdown             # Shut down the system
pmset sleepnow       # Put the Mac to sleep
```

```zsh
# ---------------------------
# show the wifi password
# ---------------------------
security find-generic-password -ga "YourWiFiName" | grep "password:"
```
