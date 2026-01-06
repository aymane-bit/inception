FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

COPY guestly /var/www/html

RUN mv /var/www/html/home.html /var/www/html/index.html

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's/listen 80/listen 4242/' /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]
