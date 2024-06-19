FROM alpine:3.19.1

ARG PHPVERSION

RUN apk update && apk upgrade && apk add \
  php${PHPVERSION} \
  php${PHPVERSION}-fpm \
  php${PHPVERSION}-mysqli \
  php${PHPVERSION}-json \
  php${PHPVERSION}-curl \
  php${PHPVERSION}-dom \
  php${PHPVERSION}-exif \
  php${PHPVERSION}-fileinfo \
  php${PHPVERSION}-mbstring \
  php${PHPVERSION}-openssl \
  php${PHPVERSION}-xml \
  php${PHPVERSION}-zip \
  php${PHPVERSION}-redis \
  php${PHPVERSION}-phar \
  php${PHPVERSION}-tokenizer \
  php${PHPVERSION}-ctype \ 
  wget \
  unzip \
  curl \
  rm -f /var/cache/apk/*

RUN ln -sf /usr/bin/php${PHPVERSION} /usr/bin/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
  chmod +x wp-cli.phar && \
  mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
  /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
  /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
  /etc/php${PHPVERSION}/php-fpm.d/www.conf

WORKDIR /var/www/wordpress

RUN chown -R nobody:nobody /var/www/wordpress

COPY ./tools/wait-for-mariadb.sh /wait-for-mariadb.sh
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /wait-for-mariadb.sh /entrypoint.sh

RUN wp core download --allow-root

CMD ["/entrypoint.sh"]