FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt install -y wget \
    php-fpm php-mysql\
    mariadb-client

#RUN wget http://wordpress.org/latest.tar.gz -P /var/www
#RUN tar -xzvf /var/www/latest.tar.gz && rm /var/www/latest.tar.gz
#RUN chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /run/php
RUN chmod 755 /run/php

COPY ./tools/wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT [ "/usr/local/bin/wp.sh" ]