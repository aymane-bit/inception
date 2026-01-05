#!/bin/sh
set -e

WP_PATH="/var/www/html"

# 1) Wait for MariaDB to be ready
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 1
done

cd "$WP_PATH"

# Read DB and WP admin passwords from secrets
WORDPRESS_DB_PASSWORD=$(cat /run/secrets/db_password.txt)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password.txt)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password.txt)

if [ ! -f wp-config.php ]; then
    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php
fi

if ! wp core is-installed --allow-root; then
    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi


mkdir -p /run/php
chown www-data:www-data /run/php

exec php-fpm7.4 -F