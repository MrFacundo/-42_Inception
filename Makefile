build:
	docker compose -f srcs/docker-compose.yml build
up:
	docker compose -f srcs/docker-compose.yml up

down:
	docker compose -f srcs/docker-compose.yml down

re: down build up

clean:
	docker system prune -a --volumes

create_dirs:
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/database_data
	mkdir -p ~/data/jekyll

delete_data:
	sudo rm -rf ~/data

fclean: delete_data
	docker stop $$(docker ps -qa); docker rm $$(docker ps -qa); docker rmi -f $$(docker images -qa); docker volume rm $$(docker volume ls -q); docker network rm $$(docker network ls -q) 2>/dev/null

.PHONY: build up down re clean fclean create_dirs delete_data