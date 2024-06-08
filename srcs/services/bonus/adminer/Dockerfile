FROM alpine:3.20.0

ARG PHPVERSION

RUN apk update && apk upgrade && apk add \
  php${PHPVERSION} \
  php${PHPVERSION}-session \
  php${PHPVERSION}-mysqli

ADD https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php /adminer.php

COPY ./services/bonus/adminer/router.php /router.php

EXPOSE 8080

CMD ["php82", "-S", "0.0.0.0:8080", "-t", "/", "router.php"]
