# Grafana

## Installation

1. Run the following command to add the Grafana repository to your system:

```bash
sudo apt install apt-transport-https software-properties-common wget
sudo wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
```

2. Update the package list and install Grafana with the following commands:

```bash
sudo apt update
sudo apt install grafana
```

3. Start the Grafana service and check its status

```bash
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl status grafana-server
```

4. Allow access to Grafana Web Interface in firewall

```bash
sudo ufw allow 3000/tcp
```

5. Set the admin password to a new value

```bash
sudo systemctl stop grafana-server
sudo grafana-cli admin reset-admin-password <new_password>
sudo systemctl start grafana-server
```

With Grafana running successfully, open your web browser and go to:

> **Note:**
> http://your-server-ip-address:3000

![Screenshot-1](./assets/prometheus_architecture.png)

[^1]: xxxxxxxxxxxxxxxxxxxx
