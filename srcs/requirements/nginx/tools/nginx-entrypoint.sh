#!/bin/sh

set -e

SSL_DIR="/etc/nginx/ssl"

if [ ! -f "$SSL_DIR/nginx.crt" ]; then
    echo "Generating self-signed SSL certificate..."

    mkdir -p $SSL_DIR

    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout $SSL_DIR/nginx.key \
        -out $SSL_DIR/nginx.crt \
        -subj "/C=MA/ST=42/L=Khouribga/O=42/CN=akajjou.42.fr"
fi

exec nginx -g "daemon off;"
