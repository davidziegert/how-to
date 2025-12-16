curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

sudo apt update
sudo apt install caddy
caddy -v
sudo systemctl enable caddy
sudo systemctl start caddy
sudo systemctl status caddy

sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php php-fpm php-cli php-common php-mysql -y

sudo systemctl enable --now php-fpm
sudo systemctl status php-fpm

sudo cp /etc/caddy/Caddyfile /etc/caddy/Caddyfile.original
> /etc/caddy/Caddyfile

cat <<EOF >> /etc/caddy/Caddyfile

:80 {
        root * /var/www/html

        file_server {
                hide .git .htaccess *.inc .idea *.phps *.bak
                index index.html index.htm index.txt index.php
        }
        
	try_files {path} {path}/index.html
	try_files {path} {path}/index.php

        php_fastcgi unix//run/php/php-fpm.sock  
        encode zstd gzip

        log {
                output file /var/log/caddy/example.log
                format console
        }
}

EOF

sudo mkdir -p /var/www/html
> /var/www/html/index.php

cat <<EOF >> /var/www/html/index.php

<?php phpinfo() ?>

EOF

chown -R caddy:caddy /var/www/html
find /var/www/html -type d -exec chmod 775 {} +
find /var/www/html -type f -exec chmod 664 {} +

sudo systemctl restart caddy
