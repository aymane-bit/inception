FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-mysql \
    wget

RUN wget "https://www.adminer.org/latest.php" -O /var/www/html/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]