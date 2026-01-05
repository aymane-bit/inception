FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx

COPY index.html /var/www/html/index.html

RUN sed -i 's/listen 80/listen 4242/' /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]