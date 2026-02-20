# ZSH

## macOS

### Command Overview

```zsh
passwd                                          # create or update passwords for existing users
whoami                                          # get the active username
```

```zsh
cd                                              # command to navigate through directories
ls                                              # command to list directories
pwd                                             # print working directory
cp                                              # copying files
mv                                              # move or rename files
ditto                                           # copying files and directories, and preserves specific file attributes, permissions, and other metadata
df -h                                           # display disk filesystem information
diff                                            # find the difference between two files
```

```zsh
ping                                            # resolves the domain name into an IP address and starts sending ICMP packages to the destination IP
ifconfig                                        # display network interfaces and IP addresses
traceroute                                      # trace all the network hops to reach the destination
dig                                             # query the Domain Name System (DNS) to retrieve information about a server
```

```zsh
say                                             # converts text to speech
pbcopy                                          # takes any text from its standard input and copies it to the system clipboard
caffeinate                                      # prevents the system from going to sleep while it is running
nano                                            # editor
man                                             # manual pages for all commands
open                                            # opens a file (or a folder or URL)
grep                                            # search for a string within an output
awk                                             # search through text files by columns/tabs
ps                                              # display active processes
top                                             # view active processes live with their system usage
kill                                            # kill active processes by process ID or name
which $SHELL                                    # shows what shell you are using
uptime                                          # displays the length of time the computer has been running since the last restart
qlmanage                                        # allows you to generate previews
curl                                            # enables you to connect to and transfer data with a remote server
history                                         # displays a list of previously executed commands
shutdown -h now                                 # shutdown the machine now
shutdown -r now                                 # restart the machine now
```

```zsh
# show the wifi password
security find-generic-password -ga "YourWiFiName" | grep "password:"
```