FROM nginx:alpine

COPY ./index.html /var/www/html/

EXPOSE 80
