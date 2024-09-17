# Prometheus

## Installation [^1] [^2]

1. Update System Packages

You should first update your system's package list to ensure that you are using the most recent packages. To accomplish this, issue the following command:

```bash
sudo apt update
```

2. Create a System User for Prometheus

Now create a group and a system user for Prometheus. To create a group and then add a user to the group, run the following command:

```bash
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
```

This will create a system user and group named "prometheus" for Prometheus with limited privileges, reducing the risk of unauthorized access.

3. Create Directories for Prometheus

To store configuration files and libraries for Prometheus, you need to create a few directories. The directories will be located in the /etc and the /var/lib directory respectively. Use the commands below to create the directories:

```bash
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
```

4. Download Prometheus and Extract Files

To download the latest update, go to the Prometheus official downloads site and copy the download link for Linux Operating System. Download using wget and the link you copied like so:

```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.54.1/prometheus-2.54.1.linux-amd64.tar.gz
```

After the download has been completed, run the following command to extract the contents of the downloaded file:

```bash
tar vxf prometheus*.tar.gz
```

5. Navigate to the Prometheus Directory

After extracting the files, navigate to the newly extracted Prometheus directory using the following command:

```bash
cd prometheus*
```

6. Move the Binary Files & Set Owner

First, you need to move some binary files (prometheus and promtool) and change the ownership of the files to the "prometheus" user and group. You can do this with the following commands:

```bash
sudo mv prometheus /usr/local/bin
sudo mv promtool /usr/local/bin
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
```

7. Move the Configuration Files & Set Owner

Next, move the configuration files and set their ownership so that Prometheus can access them. To do this, run the following commands:

```bash
sudo mv consoles /etc/prometheus
sudo mv console_libraries /etc/prometheus
sudo mv prometheus.yml /etc/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus
```

8. Create Prometheus Systemd Service

Now, you need to create a system service file for Prometheus. Create and open a prometheus.service file with the Nano text editor using:

```bash
sudo nano /etc/systemd/system/prometheus.service
```

```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

The "systems" service file for Prometheus defines how Prometheus should be managed as a system service on Ubuntu. It includes the service configuration, such as the user and group it should run as. It also includes the path to the Prometheus binary and the Prometheus configuration file location. Additionally, the file can be used to set storage locations for metrics data and pass additional command-line options to the Prometheus binary when it starts.

9. Reload Systemd

You need to reload the system configuration files after saving the prometheus.service file so that changes made are recognized by the system. Reload the system configuration files using the following:

```bash
sudo systemctl daemon-reload
```

10. Start Prometheus Service

Next, you want to enable and start your Prometheus service. Do this using the following commands:

```bash
sudo systemctl enable prometheus
sudo systemctl start prometheus
```

11. Check Prometheus Status

After starting the Prometheus service, you may confirm that it is running or if you have encountered errors using:

```bash
sudo systemctl status prometheus
```

12. Access Prometheus Web Interface

```bash
sudo ufw allow 9090/tcp
```

With Prometheus running successfully, you can access it via your web browser using localhost:9090 or <ip_address>:9090

[^1]: https://www.cherryservers.com/blog/install-prometheus-ubuntu
[^2]: https://medium.com/@abdullah.eid.2604/prometheus-installation-on-linux-ubuntu-c4497e5154f6
[^3]: https://ibrahims.medium.com/how-to-install-prometheus-and-grafana-on-ubuntu-22-04-lts-configure-grafana-dashboard-5d11e3cb3cfd
