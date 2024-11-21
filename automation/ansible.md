# Ansible

```
your-server-ip-address > [IPADDRESS]
your-server-url > [URL]
your-server-name > [SERVER]
your-user-name > [USER]
your-user-password > [PASSWORD]
your-user-database > [DATABASE]
your-user-email > [EMAIL]
ansible-group-of-servers > [HOST_GROUP]
```

## Installation

```bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

```bash
sudo ansible --version
```

## Configuration

You can generate the default configuration file using the command:

```bash
sudo ansible-config init --disabled -t all > ansible.cfg
```

Configure Ansible: You can modify Ansible’s configuration settings by editing its configuration file:

```bash
sudo nano /etc/ansible/ansible.cfg
```

Example: https://github.com/ansible/ansible/blob/stable-2.9/examples/ansible.cfg

```
[defaults]

# location of inventory file
inventory           =   /etc/ansible/hosts

# location of ansible library
library             =   /usr/share/ansible

# directory where temp files are stored
remote_tmp          =   ~/.ansible/tmp
local_tmp           =   ~/.ansible/tmp

# logging is off by default unless this path is defined if so defined, consider logrotate
log_path            =   /var/log/ansible.log

# the default number of forks (parallelism) to be used. Usually you can crank this up.
forks               =   100

# the timeout used by various connection types.  Usually this corresponds to an SSH timeout
timeout             =   10

# when using --poll or "poll:" in an ansible playbook, and not specifying an explicit poll interval, use this interval
poll_interval       =   15

# when specifying --sudo to /usr/bin/ansible or "sudo:" in a playbook, # and not specifying "--sudo-user" or "sudo_user" respectively, sudo to this user account
sudo_user           =   root

# the default sudo executable. If a sudo alternative with a sudo-compatible interface is used, specify its executable name as the default
sudo_exe            =   sudo

# remote SSH port to be used when --port or "port:" or an equivalent inventory
remote_port         =   22

# uncomment this to disable SSH key host checking
host_key_checking   =   False
```

### Setting up SSH keys

```bash
ssh-keygen
ssh-copy-id -p 22 [USER]@[IPADDRESS]
```

### Create an Inventory

Create Inventory File: Ansible uses an inventory file to keep track of the servers it manages.

```bash
sudo nano /etc/ansible/hosts
```

Add your servers under appropriate groups for better organization.

```
localhost ansible_connection=local

# Ex 1: Ungrouped servers

localhost
server1 ansible_host=[IPADDRESS] ansible_user=[USER]

# Ex 2: A collection of hosts belonging to the 'ubuntu' group:

[ubuntu]
localhost
server1 ansible_host=[IPADDRESS] ansible_user=[USER]
```

### Listing all servers

```bash
sudo ansible all --list-hosts
sudo ansible [HOST_GROUP] --list-hosts
sudo ansible-inventory --list -y
```

### Testing Ansible Connection

Test Connection: Run a simple Ansible command to check if Ansible can connect to the servers listed in your inventory file:

```bash
sudo ansible all -m ping
sudo ansible [HOST_GROUP] -m ping
```

## Playbooks

- [Updates on Ubuntu](./updates.yml)

```bash
sudo ansible-playbook /etc/ansible/updates.yml --syntax-check
sudo ansible-playbook /etc/ansible/updates.yml --ask-become-pass
```

[^1]: https://spacelift.io/blog/ansible-best-practices
[^2]: https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#best-practices
[^3]: https://atix.de/en/blog/ansible-best-practices/
[^4]: https://www.virtualizationhowto.com/2024/01/how-to-update-ubuntu-with-ansible/
[^5]: https://luisjohnstone.com/2023/10/ubuntu-unattended-updates-with-ansible.html
