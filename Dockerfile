FROM ubuntu:20.04

ENV index /var/www/html/index.html
ENV usr_share_index /usr/share/nginx/html/index.html
ENV nginx_vhost /etc/nginx/sites-available/default

RUN apt-get update \ 
    && apt-get install nginx -y

COPY default ${nginx_vhost}
COPY index.html ${index}
COPY index.html ${usr_share_index}

EXPOSE 80
