# How To - Linux - Tools - DNS (Ubuntu) [^1] [^2]

## Installation

```
sudo apt install bind9 bind9utils bind9-dnsutils bind9-doc bind9-host
```

```
sudo systemctl enable bind9
sudo systemctl start bind9
sudo systemctl restart bind9
sudo systemctl reload bind9
sudo systemctl status bind9
```

```

```

```
sudo named-checkconf
```

[^1]:https://serverspace.io/support/help/configure-bind9-dns-server-on-ubuntu/
[^2]:https://www.2daygeek.com/start-stop-restart-enable-reload-bind-dns-named-server-service-in-linux/