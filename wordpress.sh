apt update

apt install apache2 unzip php mysql-server php-mysql -y  

wget https://ca.wordpress.org/latest-ca.zip

unzip latest-ca.zip -d /var/www/html/ 

mv /var/www/html/wordpress/* /var/www/html/

rm /var/www/html/index.html

chown -R www-data:www-data /var/www/html

mysql -e "CREATE DATABASE wordpress"
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin'"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost'; FLUSH PRIVILEGES"
