#!/bin/bash
set -e

cat <<EOF > /etc/sysconfig/mariadb-init
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}
EOF

exec /usr/sbin/init "$@"
