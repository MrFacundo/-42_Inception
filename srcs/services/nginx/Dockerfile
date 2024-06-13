FROM alpine:3.19.1

RUN apk update && apk add nginx openssl \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /etc/nginx/ssl/ \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/nginx.key \
		-out /etc/nginx/ssl/nginx.crt \
		-subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

COPY ./config/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]