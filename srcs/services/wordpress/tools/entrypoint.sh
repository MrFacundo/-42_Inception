#!/bin/sh

/wait-for-mariadb.sh mariadb:3306

if [ ! -f wp-config.php ]; then
	wp core config --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST

	if ! $(wp core is-installed --allow-root); then 
		wp core install --allow-root --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL
	fi

	if ! $(wp user get $WP_USER --field=user_login --allow-root | grep -q "^$WP_USER$"); then 
		wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root
	fi
fi

/usr/sbin/php-fpm82 -F