#!/bin/sh

/wait-for-mariadb.sh mariadb:3306

if [ ! -f wp-config.php ]; then
	wp core config --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST
fi

wp config set WP_REDIS_HOST $REDIS_HOST --type=constant --allow-root
wp config set WP_REDIS_PORT $REDIS_PORT --type=constant --allow-root
wp config set WP_REDIS_TIMEOUT $REDIS_TIMEOUT --type=constant --allow-root
wp config set WP_REDIS_READ_TIMEOUT $REDIS_READ_TIMEOUT --type=constant --allow-root
wp config set WP_REDIS_DATABASE $REDIS_DATABASE --type=constant --allow-root
wp config set WP_REDIS_DISABLE_DROPIN_CHECK true --type=constant --allow-root

wp config set WP_DEBUG true --raw --allow-root
wp config set WP_DEBUG_LOG true --raw --allow-root
wp config set WP_DEBUG_DISPLAY true --raw --allow-root

chown -R nobody:nobody /var/www/wordpress/wp-content

if ! $(wp core is-installed --allow-root); then 
	wp core install --allow-root --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL
fi

if ! $(wp user get $WP_USER --field=user_login --allow-root | grep -q "^$WP_USER$"); then 
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root
else
	echo "User $WP_USER already exists."
fi

if ! $(wp plugin is-installed redis-cache --allow-root); then
	wp plugin install redis-cache --allow-root
fi


if ! $(wp plugin is-active redis-cache --allow-root); then
	wp plugin activate redis-cache --allow-root
fi


if ! $(wp plugin is-installed query-monitor --allow-root); then
	wp plugin install query-monitor --allow-root
fi

if ! $(wp plugin is-active query-monitor --allow-root); then
	wp plugin activate query-monitor --allow-root
fi

wp redis enable --allow-root

/usr/sbin/php-fpm82 -F