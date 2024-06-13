FROM alpine:3.19.1

RUN apk update && apk upgrade && apk add --no-cache \
        vsftpd

RUN mkdir -p /var/run/vsftpd/empty

COPY ./config/vsftpd.conf /etc/

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]