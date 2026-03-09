# BASH

## Linux (Ubuntu)

### Command Overview

```bash+
# ---------------------------
# Session / Terminal Control
# ---------------------------
ssh                 # Secure Shell: connect to a remote system
exit                # Exit the current shell session
clear               # Clear the terminal display
history             # Display previously executed commands
alias               # Create custom shortcuts for commands

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
mv                  # Move or rename files or directories
rm                  # Delete files or directories
shred               # Securely delete a file by overwriting its contents
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
echo                # Print text to the terminal or redirect to files

# ---------------------------
# File Comparison & Processing
# ---------------------------
cmp                 # Compare two files byte by byte
diff                # Show differences between two files
comm                # Compare two sorted files line by line
sort                # Sort lines in a file
grep                # Search for patterns in text
awk                 # Pattern scanning and text processing (column-based)

# ---------------------------
# File Search & Permissions
# ---------------------------
find                # Search for files and directories
chmod               # Change file permissions
chown               # Change file ownership

# ---------------------------
# Compression & Archiving
# ---------------------------
tar                 # Create or extract archive files
zip                 # Compress files into a zip archive
unzip               # Extract zip archives

# ---------------------------
# Networking
# ---------------------------
curl                # Transfer data from or to a server
wget                # Download files from the internet
ping                # Test connectivity to a host
traceroute          # Show the network path to a destination
ifconfig            # Display network interfaces (legacy)
ip address          # Show or configure network interfaces
resolvectl status   # Display DNS resolver status
netstat             # Show network connections and statistics (legacy)
ss                  # Display socket statistics

# ---------------------------
# Firewall
# ---------------------------
iptables            # Configure Linux kernel firewall rules
ufw                 # Uncomplicated Firewall management tool

# ---------------------------
# User Management
# ---------------------------
whoami              # Display the current username
finger              # Show information about system users
useradd             # Add a new user (basic)
adduser             # Add a new user (interactive)
usermod             # Modify user account settings
passwd              # Change or set a user password
su                  # Switch user identity
sudo                # Execute commands with elevated privileges

# ---------------------------
# Package Management
# ---------------------------
apt                 # Package manager for Debian/Ubuntu
pacman              # Package manager for Arch Linux
yum                 # Package manager for older RHEL/CentOS
rpm                 # Low-level RPM package manager

# ---------------------------
# System Information
# ---------------------------
uname               # Display basic system information
neofetch            # Show detailed system information (visual)
free                # Show memory usage
df                  # Display disk space usage

# ---------------------------
# Process Management
# ---------------------------
ps                  # Show running processes
top                 # Display real-time process usage
htop                # Interactive process viewer
kill                # Terminate a process by PID
pkill               # Terminate processes by name or attributes

# ---------------------------
# System Services
# ---------------------------
systemctl           # Manage systemd services (start, stop, restart, status)

# ---------------------------
# File Systems
# ---------------------------
mount               # Mount a filesystem

# ---------------------------
# Help & Documentation
# ---------------------------
man                 # Display the manual page for a command
whatis              # Show a short description of a command
whereis             # Locate binaries, source, and man pages

# ---------------------------
# System Power
# ---------------------------
reboot              # Restart the system
shutdown            # Safely power off the system
```