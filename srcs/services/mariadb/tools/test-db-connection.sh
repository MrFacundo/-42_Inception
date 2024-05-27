#!/bin/sh

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=password
DB_NAME=test

mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "SHOW DATABASES LIKE '$DB_NAME';"