FROM alpine:3.20.0

RUN apk update && apk add mariadb mariadb-client && rm -rf /var/cache/apk/*

# Initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy the script
COPY ./tools/test-db-connection.sh /test-db-connection.sh
RUN chmod +x /test-db-connection.sh

# Start the MariaDB server and then run the script
CMD sh -c 'mysqld_safe --datadir=/var/lib/mysql &' && sleep 5 && /test-db-connection.sh