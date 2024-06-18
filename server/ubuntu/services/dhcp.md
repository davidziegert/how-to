# DHCP (Ubuntu)

## ISC

### Installation

```bash
sudo apt install isc-dhcp-server
```

### Configuration

```bash
sudo cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.original
sudo nano /etc/dhcp/dhcpd.conf
```

```
# Settings

authoritative;
ddns-update-style none;
ddns-updates off;

default-lease-time 10800;
max-lease-time 21600;

deny unknown-clients;
deny bootp;

option domain-name "subdomain.domain.tld";
option domain-name-servers xxx.xxx.xxx.xxx;
option subnet-mask 255.255.255.0;
option routers xxx.xxx.xxx.xxx;
option broadcast-address xxx.xxx.xxx.255;
```

```
# Subnet

subnet xxx.xxx.xxx.0 netmask 255.255.255.0
{
    range xxx.xxx.xxx.xxx xxx.xxx.xxx.xxx;

    host PC001 {hardware ethernet 00:00:00:00:00:00; fixed-address 000.000.000.000;}
    host PC002 {hardware ethernet 00:00:00:00:00:00;}
    ...
}
```

```bash
sudo mkdir -p /var/run/dhcp-server
sudo chown dhcpd:dhcpd /var/run/dhcp-server
```

### Commands

```bash
sudo dhcpd -t -cf /etc/dhcp/dhcpd.conf

sudo systemctl enable isc-dhcp-server.service
sudo systemctl start isc-dhcp-server.service
sudo systemctl status isc-dhcp-server.service
sudo systemctl restart isc-dhcp-server.service

sudo dhcp-lease-list
```
