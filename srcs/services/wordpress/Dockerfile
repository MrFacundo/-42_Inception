FROM alpine:3.20.0

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
  wget \
  unzip && \
  sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
  /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
  /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
  /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  echo "env[DB_NAME] = \$DB_NAME" >> /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  echo "env[DB_HOST] = \$DB_HOST" >> /etc/php${PHPVERSION}/php-fpm.d/www.conf && \
  rm -f /var/cache/apk/*
WORKDIR /var/www
RUN chown -R nobody:nobody /var/www
RUN wget https://wordpress.org/latest.zip && \
  unzip latest.zip && \
  cp -rf wordpress/* . && \
  rm -rf wordpress latest.zip
CMD ["/usr/sbin/php-fpm82", "-F"]

