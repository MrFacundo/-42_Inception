FROM alpine:3.20.0

RUN apk update && apk add nginx \
	rm -rf /var/cache/apk/*

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]