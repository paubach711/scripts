# packages installation
sudo su
apt update
apt install apache2 unzip php mysql-server php-mysql ssl-cert -y  

# wordpress install
wget https://ca.wordpress.org/latest-ca.zip
unzip latest-ca.zip -d /var/www/html/ 
mv /var/www/html/wordpress/* /var/www/html/
rm /var/www/html/index.html
chown -R www-data:www-data /var/www/html

# database creation
mysql -e "CREATE DATABASE wordpress"
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin'"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost'; FLUSH PRIVILEGES"

# ssl
make-ssl-cert generate-default-snakeoil --force-overwrite
a2enmod ssl
sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:443>\n\tSSLEngine On\n\tSSLCertificateFile \/etc\/ssl\/certs\/ssl-cert-snakeoil.pem\n\tSSLCertificateKeyFile \/etc\/ssl\/private\/ssl-cert-snakeoil.key/' /etc/apache2/sites-enabled/000-default.conf
systemctl restart apache2
exit
