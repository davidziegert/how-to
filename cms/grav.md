# WordPress

## Installation

### Requirements

```bash
sudo apt install apache2
sudo systemctl enable apache2
sudo systemctl status apache2
```

```bash
sudo apt install -y php php-cli php-fpm php-common php-curl php-gd php-json php-mbstring php-xml php-zip php-opcache php-apcu unzip -y
sudo php -v
```

```bash
sudo nano /etc/php/8.3/fpm/php.ini
    memory_limit = 256M
    upload_max_filesize = 100M
    max_execution_time = 360
    max_input_vars = 1500
    date.timezone = Your_Timezone (make sure you uncomment this line, remove the ; in front of the line)
```

### Configuration

```bash
sudo apt install wget unzip
```

```bash
sudo wget sudo wget https://getgrav.org/download/core/grav-admin/grav.zip
sudo unzip grav.zip
sudo mv grav/ /var/www/html/
csudo hown -R www-data:www-data /var/www/html/grav
sudo rm grav.zip
sudo rm /var/www/html/index.html
```

```
http://your-server-ip-address
```

![Screenshot-1](./assets/grav_install_1.png)
![Screenshot-2](./assets/grav_install_2.png)
![Screenshot-3](./assets/grav_install_3.png)

## Security

```bash
sudo nano /var/www/html/grav/user/config/system.yaml
```

```yaml
force_ssl: true       # Use HTTPS only (redirect from HTTP -> HTTPS)

cache:
  enabled: true       # Greatly speeds up the site
  check:
    method: hash      # Optimization, disables file modification checks for pages

twig:
  cache: true         # Greatly speeds up the site
  debug: false        # We do not want to display debug messages
  auto_reload: false  # Optimization, disables file modification checks for twig files
  autoescape: true    # Protects from many XSS attacks, but requires twig updates if used in older sites/themes/plugins

errors:
  display: 0          # Display only a simple error
  log: true           # Log errors for later inspection

debugger:
  enabled: false      # Never keep debugger enabled in a live site.
  censored: true      # In case if you happen to enable debugger, avoid displaying sensitive information

session:
  enabled: true       # NOTE: Disable sessions if you do not use user login and/or forms.
  secure: true        # Use this as your site should be using HTTPS only
  httponly: true      # Protects session cookies against client side scripts and XSS
  samesite: Strict    # Prevent all cross-site scripting attacks
  split: true         # Separate admin session from the site session for added security

strict_mode:          # Test your site before changing these. Removes backward compatibility and improves site security.
  yaml_compat: false
  twig_compat: false
  blueprint_compat: false
```