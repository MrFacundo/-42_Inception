FROM alpine:3.20.0

ENV DB_NAME \
    DB_USER

RUN apk update && apk add  mariadb mariadb-client

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY ./services/mariadb/tools/create_db.sh .

USER mysql
CMD ["/bin/sh", "-c", "sh create_db.sh && /usr/bin/mysqld --skip-log-error"]