#!/bin/bash
export wordpress=/tmp/wordpress
export apache=/var/www/html

# Install required packages
yum install -y mariadb-server httpd wget
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2

# Enable and start apache and mariadb services
systemctl enable --now mariadb httpd

# Set mariadb root password
mysqladmin -u root password admin

# Wordpress installation
mkdir -pv $wordpress
wget https://wordpress.org/latest.tar.gz -P $wordpress
tar -xzvf $wordpress/latest.tar.gz --strip-components=1 --directory /var/www/html
rm -rf $wordpress

# Create wordpress config file
cp $apache/wp-config-sample.php $apache/wp-config.php

# Modify config file
sed -i 's/database_name_here/wordpress_db/g' $apache/wp-config.php
sed -i 's/username_here/admin/g' $apache/wp-config.php
sed -i 's/password_here/admin/g' $apache/wp-config.php

# Change ownership of /var/www/html to apache user and group
chown apache:apache -R $apache/

# Setting up DB 
cat << EOF > /tmp/db.txt
CREATE DATABASE wordpress_db;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL ON wordpress_db.* TO admin@localhost;
FLUSH PRIVILEGES;
EOF

mysql -u root --password=admin < /tmp/db.txt
rm -rf /tmp/db.txt