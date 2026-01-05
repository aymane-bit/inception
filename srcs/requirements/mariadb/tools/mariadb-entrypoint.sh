#!/bin/sh
set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password.txt)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password.txt)

: "${MYSQL_DATABASE:?Missing MYSQL_DATABASE}"
: "${MYSQL_USER:?Missing MYSQL_USER}"

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    cat << EOF > /tmp/init_db.sql
USE mysql;
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
EOF

    /usr/sbin/mysqld --user=mysql --bootstrap < /tmp/init_db.sql
    rm -f /tmp/init_db.sql
fi

exec /usr/sbin/mysqld --user=mysql --console
