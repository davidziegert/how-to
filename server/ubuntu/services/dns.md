# DNS (Ubuntu) [^1] [^2] [^3] [^4] [^5] [^6] [^7] [^8] [^9] [^10]

## BIND9

### Installation

```bash
sudo apt install bind9 bind9utils bind9-dnsutils bind9-doc bind9-host
```

```bash
sudo systemctl enable bind9
sudo systemctl start bind9
sudo systemctl restart bind9
sudo systemctl reload bind9
sudo systemctl status bind9
sudo rndc status
```

### Configuration (Part 1)

#### named.conf

```bash
sudo cp /etc/bind/named.conf /etc/bind/named.conf.original
sudo nano /etc/bind/named.conf
```

```
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
include "/etc/bind/named.conf.default-zones";
```

#### named.conf.options

```bash
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.original
sudo nano /etc/bind/named.conf.options
```

```
options
{
    directory "/var/cache/bind";
    dnssec-validation auto;
    auth-nxdomain no;
    listen-on-v6 { any; };

    // hide version number from clients for security reasons.
    version "not currently available";

    // disable recursion on authoritative DNS server.
    recursion no;
    allow-recursion { none; };
    empty-zones-enable no;

    allow-query { any; };
    // enable the query log
    querylog yes;

    // disallow zone transfer to other dns servers, if not then "none"
    allow-transfer { xxx.xxx.xxx.xxx; };
    also-notify { xxx.xxx.xxx.xxx; };

    empty-zones-enable no;
};
```

#### named.conf.local

```bash
sudo cp /etc/bind/named.conf.local /etc/bind/named.conf.local.original
sudo nano /etc/bind/named.conf.local
```

```
// zone files for dns subnet
// example for 192.168.1.0/24
// example for subdomain.domain.tld

zone "1.168.192.in-addr.arpa"
{
    type master;
    file "/etc/bind/192.168.1.zone";
    allow-update { none; }; // Since this is the primary DNS, it should be none.
};

zone "subdomain.domain.tld"
{
    type master;
    file "/etc/bind/subdomain.domain.tld.zone";
    allow-update { none; }; // Since this is the primary DNS, it should be none.
};
```

#### named.conf.default-zones

```bash
sudo cp /etc/bind/named.conf.default-zones /etc/bind/named.conf.default-zones.original
sudo nano /etc/bind/named.conf.default-zones
```

```
// prime the server with knowledge of the root servers

zone "."
{
    type hint;
    file "/etc/bind/db.root";
};

// be authoritative for the localhost forward and reverse zones, and for
// broadcast zones as per RFC 1912

zone "localhost"
{
    type master;
    file "/etc/bind/db.local";
};

zone "127.in-addr.arpa"
{
    type master;
    file "/etc/bind/db.127";
};

zone "0.in-addr.arpa"
{
    type master;
    file "/etc/bind/db.0";
};

zone "255.in-addr.arpa"
{
    type master;
    file "/etc/bind/db.255";
};
```

### Configuration Part 2

#### 192.168.1.zone

```bash
sudo nano /etc/bind/192.168.1.zone
```

```
$TTL 86400

@       IN      SOA     mydns.subdomain.domain.tld.     root.subdomain.domain.tld.
(
                        2022000001  ; Serial number
                        28800       ; Refresh
                        3600        ; Retry
                        604800      ; Expire
                        86400       ; Negative Cache TTL
)

;Name Server Information
@       IN      NS      mydns.subdomain.domain.tld.
@       IN      NS      otherdns.subdomain.domain.tld.

;IP address of Name Server
mydns.subdomain.domain.tld.     IN  A   192.168.1.1
otherdns.subdomain.domain.tld.  IN  A   192.168.2.1

;Reverse lookup for Name Server
1       IN      PTR     mydns.subdomain.domain.tld.

;PTR Record IP address to HostName
2       IN      PTR     two.subdomain.domain.tld.
3       IN      PTR     three.subdomain.domain.tld.
4       IN      PTR     four.subdomain.domain.tld.
```

#### subdomain.domain.tld.zone

```bash
sudo nano /etc/bind/subdomain.domain.tld.zone
```

```
$TTL 86400

@       IN      SOA     mydns.subdomain.domain.tld.     root.subdomain.domain.tld.
(
                        2022000001  ; Serial number
                        28800       ; Refresh
                        3600        ; Retry
                        604800      ; Expire
                        86400       ; Negative Cache TTL
)

;Name Server Information
@       IN      NS      mydns.subdomain.domain.tld.
@       IN      NS      otherdns.subdomain.domain.tld.

;IP address of Name Server
mydns.subdomain.domain.tld.     IN  A   192.168.1.1
otherdns.subdomain.domain.tld.  IN  A   192.168.2.1

;A – Record HostName To Ip Address
two     IN      A       192.168.1.2
three   IN      A       192.168.1.3
four    IN      A       192.168.1.4

;CNAME record
alternative     IN      CNAME       two
othername       IN      CNAME       three
secondnname     IN      CNAME       four
```

```bash
sudo named-checkconf

sudo named-checkzone subdomain.domain.tld /etc/bind/subdomain.domain.tld.zone
sudo named-checkzone 1.168.192.in-addr.arpa /etc/bind/192.168.1.zone

sudo dig two.subdomain.domain.tld
sudo dig alternative.subdomain.domain.tld
```

[^1]: https://serverspace.io/support/help/configure-bind9-dns-server-on-ubuntu/
[^2]: https://www.2daygeek.com/start-stop-restart-enable-reload-bind-dns-named-server-service-in-linux/
[^3]: https://www.zytrax.com/books/dns/ch7/view.html
[^4]: https://www.linuxbabe.com/ubuntu/set-up-authoritative-dns-server-ubuntu-18-04-bind9
[^5]: https://ostechnix.com/install-and-configure-dns-server-ubuntu-16-04-lts/
[^6]: https://www.bitforce.io/internet/howto-bind9-dns-server-auf-debian-ubuntu-aufsetzen/
[^7]: https://www.hiroom2.com/2018/05/06/ubuntu-1804-bind-en/
[^8]: https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-configure-dns-server-on-ubuntu-18-04.html
[^9]: https://computingforgeeks.com/configure-master-bind-dns-server-on-ubuntu/
[^10]: https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/
