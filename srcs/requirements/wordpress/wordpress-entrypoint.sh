#!/bin/sh

set -e

WP_PATH="/var/www/html"

if [ ! -f "$WP_PATH/wp-config.php" ]; then

    cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php

    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" $WP_PATH/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" $WP_PATH/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" $WP_PATH/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" $WP_PATH/wp-config.php
fi

mkdir -p /run/php
chown www-data:www-data /run/php
exec php-fpm7.4 -F
