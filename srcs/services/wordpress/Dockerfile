FROM alpine:3.20.0

RUN apk update && apk add lighttpd php82 fcgi php82-cgi

COPY ./tools/lighttpd.conf /etc/lighttpd/lighttpd.conf

COPY ./tools/mod_fastcgi.conf /etc/lighttpd/mod_fastcgi.conf

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd2.conf"]
