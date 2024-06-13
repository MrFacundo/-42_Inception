FROM alpine:3.20.0

RUN apk update && apk upgrade && apk add --no-cache \
        vsftpd

RUN mkdir -p /var/run/vsftpd/empty

COPY ./config/vsftpd.conf /etc/

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]