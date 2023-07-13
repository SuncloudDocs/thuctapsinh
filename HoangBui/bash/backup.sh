#!/bin/bash

# Backup directory
backup_dir="/home/hoang/backup"

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