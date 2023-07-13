#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 
   exit 1
fi

# Function to install required packages on Ubuntu
install_packages_ubuntu() {
    apt update
    apt install -y apache2 mariadb-server wget php libapache2-mod-php php-mysql php-gd php-curl 
    systemctl enable apache2
    systemctl enable mariadb
    systemctl start apache2
    systemctl start mariadb
}

# Function to install required packages on CentOS
install_packages_centos() {
    yum update
    yum install -y httpd mariadb-server wget
    yum install -y epel-release yum-utils
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    yum-config-manager --enable remi-php81
    yum install -y php php-mysql php-gd php-xml php-mbstring
    systemctl enable httpd
    systemctl enable mariadb
    systemctl start httpd
    systemctl start mariadb
}

# Function to configure MariaDB
configure_mariadb() {
    echo "Configuring MariaDB..."
    mysql -e "CREATE DATABASE wordpress;"
    mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
    mysql -e "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
}

# Function to download and extract WordPress
download_wordpress() {
    echo "Downloading and extracting WordPress..."
    wget -q https://wordpress.org/latest.tar.gz
    tar xf latest.tar.gz -C /var/www/html/
    if grep -qiE "ubuntu|debian" /etc/*release; then
        chown -R www-data:www-data /var/www/html/wordpress
    elif grep -qiE "centos|fedora" /etc/*release; then
        chown -R apache:apache /var/www/html/wordpress/
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi
    
    chmod -R 755 /var/www/html/wordpress
    cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
    sed -i 's/database_name_here/wordpress/g' /var/www/html/wordpress/wp-config.php
    sed -i 's/username_here/wordpressuser/g' /var/www/html/wordpress/wp-config.php
    sed -i 's/password_here/password/g' /var/www/html/wordpress/wp-config.php
}

# Function to configure Apache virtual host on Ubuntu
configure_apache_vhost_ubuntu() {
    echo "Configuring Apache virtual host..."
    cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html/wordpress
	<Directory /var/www/html/wordpress>
    	DirectoryIndex index.php
    	AllowOverride All
		Require all granted
	</Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
    a2enmod rewrite
    systemctl reload apache2
}

# Function to configure Apache virtual host on CentOS
configure_apache_vhost_centos() {
    echo "Configuring Httpd virtual host..."
    cat > /etc/httpd/conf.d/wordpress.conf <<EOF
<VirtualHost *:80>
   ServerAdmin webmaster@example.com
   DocumentRoot /var/www/html/wordpress

   <Directory /var/www/html/wordpress/>
      AllowOverride All
      Order allow,deny
      allow from all
   </Directory>

   ErrorLog /var/log/httpd/your_domain.com-error_log
   CustomLog /var/log/httpd/your_domain.com-access_log common
</VirtualHost>
EOF
    firewall-cmd --permanent --add-service=http
    firewall-cmd --reload
    systemctl restart httpd
}

setup_auto_backup() {
    echo "Setting up automatic backups..."
    # Replace the following placeholders with your backup script/command
    # e.g., Use 'mysqldump' command to back up the MySQL database
    # and 'tar' command to compress the WordPress source code
    backup_script="/var/www/html/wordpress/backup.sh"
    cron_job="0 0 * * * $backup_script"
    (crontab -l ; echo "$cron_job") | crontab -
}

# Check the Linux distribution
if grep -qiE "ubuntu|debian" /etc/*release; then
    install_packages_ubuntu
    configure_apache_vhost_ubuntu
elif grep -qiE "centos|fedora" /etc/*release; then
    install_packages_centos
    configure_apache_vhost_centos
else
    echo "Unsupported Linux distribution."
    exit 1
fi

configure_mariadb
download_wordpress

# Create backup script
mkdir /var/www/html/wordpress/wordpress_backup_dir
cat > /var/www/html/wordpress/backup.sh <<<'
#!/bin/bash

# Backup directory
backup_dir="/var/www/html/wordpress/wordpress_backup_dir"

# WordPress directory
wordpress_dir="/var/www/html/wordpress"

# MySQL database details
db_user="wordpressuser"
db_password="password"
db_name="wordpress"

# Date format for backup files
date_format=$(date +%Y%m%d%H%M%S)

# Backup filename
backup_filename="wordpress_backup_$date_format.tar.gz"

# Backup WordPress source code
backup_wordpress() {
    echo "Backing up WordPress source code..."
    tar -czvf "$backup_dir/$backup_filename" -C "$wordpress_dir" .
}

# Backup MySQL database
backup_database() {
    echo "Backing up MySQL database..."
    mysqldump -u "$db_user" -p"$db_password" "$db_name" > "$backup_dir/database_$date_format.sql"
}

# Cleanup previous backups
cleanup_backups() {
    echo "Deleting old backup files..."
    # Set the number of days after which backup files should be deleted
    # e.g., 30 days
    retention_days=30
    find "$backup_dir" -type f -name "*.tar.gz" -mtime +"$retention_days" -delete
    find "$backup_dir" -type f -name "*.sql" -mtime +"$retention_days" -delete
}

# Execute backup functions
backup_wordpress
backup_database
cleanup_backups

echo "Backup completed successfully."
'
chmod +x /var/www/html/wordpress/backup.sh


# Display successfull notification
echo "WordPress setup completed successfully."
echo "Open your web browser and visit http://your_domain.com or http://your_server_ip_address"

