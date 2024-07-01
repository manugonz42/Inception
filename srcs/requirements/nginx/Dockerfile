FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default

RUN mkdir -p /var/run/nginx

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY ./tools/nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/nginx.sh
RUN /usr/local/bin/nginx.sh

CMD [ "nginx", "-g", "daemon off;" ]
