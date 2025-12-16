sudo apt update
sudo apt install mysql-server -y
mysql --version
sudo systemctl enable mysql
sudo systemctl start mysql
sudo systemctl status mysql
sudo mysql_secure_installation
sudo systemctl restart mysqld
sudo mysql -u root -p

# mysql> CREATE DATABASE db_test;
# mysql> CREATE USER 'USER'@'localhost' IDENTIFIED BY 'PASSWORD';
# mysql> GRANT ALL PRIVILEGES ON db_test.* TO 'USER'@'localhost';
# mysql> FLUSH PRIVILEGES;
# mysql> Exit
