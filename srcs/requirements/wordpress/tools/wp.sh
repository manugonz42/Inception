#! /bin/bash

wait_for_mariadb() {
    until mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" &> /dev/null; do
        echo "Esperando a que MariaDB esté disponible..."
        sleep 1
    done
    echo "MariaDB está disponible. Continuando..."
}

# Llamada a la función para esperar a que MariaDB esté disponible
wait_for_mariadb


if [ -f /var/www/html/wp-config.php ]
then
	echo "Wordpress already exists"
else
	echo Waiting 10 secs...
	echo Configuring wp...
    cd /var/www/html
	wp core download --allow-root
	#wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME
	wp config create --allow-root --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOSTNAME"
	wp core install --url=$DONAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIM --admin_password=$WORDPRESS_ADMIM_PASS  --admin_email=$WORDPRESS_ADMIM_EMAIL --skip-email --allow-root
	wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root
	wp theme install twentysixteen --activate --allow-root
    cd
	echo done
fi

/usr/sbin/php-fpm7.4 -F;