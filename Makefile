build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

re: down build up

clean:
	docker system prune -a --volumes

.PHONY: build up down re clean
