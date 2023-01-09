FROM ubuntu:latest

ENV index /var/www/html/index.html
ENV usr_share_index /usr/share/nginx/html/index.html

RUN apt-get update && \
    apt-get install nginx -y && \
    rm /var/www/hmtl/index.nginx-debian.html

COPY index.html ${index}
COPY index.html ${usr_share_index}

EXPOSE 80
