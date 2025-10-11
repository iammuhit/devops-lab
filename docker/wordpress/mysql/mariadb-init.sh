#!/bin/bash
set -euo

# Ensure data directory exists and is owned by mysql user
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

# Initialize database if empty
if [ ! -d "/var/lib/mysql/mysql" ] || [ -z "$(ls -A /var/lib/mysql 2> /dev/null)" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start temporary mysqld without networking for provisioning
mysqld --skip-networking --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock & pid="$!"

# Wait for MariaDB to be ready
while ! mysqladmin ping --silent; do
    sleep 1
done

# If root password requested, set it
if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
    mysql -uroot <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL
fi

# Create database if requested
if [ -n "$MYSQL_DATABASE" ]; then
    mysql -uroot ${MYSQL_ROOT_PASSWORD:+-p${MYSQL_ROOT_PASSWORD}} <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
EOSQL
fi

# Create user and grant privileges if requested
if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
    mysql -uroot ${MYSQL_ROOT_PASSWORD:+-p${MYSQL_ROOT_PASSWORD}} <<-EOSQL
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL ON \`${MYSQL_DATABASE:-*}\`.* TO '${MYSQL_USER}'@'localhost';
        FLUSH PRIVILEGES;
EOSQL
fi

# Shutdown temporary mysqld server
mysqladmin -uroot ${MYSQL_ROOT_PASSWORD:+-p${MYSQL_ROOT_PASSWORD}} shutdown || true
wait "$pid" || true

# systemctl enable mariadb
# systemctl restart mariadb
