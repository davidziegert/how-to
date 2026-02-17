sudo apt install php-cli
sudo apt install php-xml
sudo apt install curl php-mbstring git unzip
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

cd /var/www/html/workdir
composer require erusev/parsedown