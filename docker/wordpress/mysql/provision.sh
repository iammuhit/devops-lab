#!/bin/bash

set -euo pipefail

# Ensure data directory exists and is owned by mysql user
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Initialize database if empty
if [ -z "$(ls -A /var/lib/mysql 2> /dev/null)" ] || [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database directory ..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  chown -R mysql:mysql /var/lib/mysql
  echo "Database directory initialized"
fi

# Launches mysqld in foreground as mysql user
exec mysqld --user=mysql --datadir='/var/lib/mysql' "$@"
