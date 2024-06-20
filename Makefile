DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = ~/data
BLUE = \033[1;34m
RESET = \033[0m

define print_blue
	@echo -e "$(BLUE)$(1)$(RESET)"
endef

build:
	$(call print_blue, "Building Docker images...")
	docker compose -f $(DOCKER_COMPOSE_FILE) build

up: create_dirs
	$(call print_blue, "Starting Docker containers...")
	docker compose -f $(DOCKER_COMPOSE_FILE) up

down:
	$(call print_blue, "Stopping Docker containers...")
	docker compose -f $(DOCKER_COMPOSE_FILE) down

re: down build up
	$(call print_blue, "Rebuilding and restarting Docker containers...")

clean:
	$(call print_blue, "Cleaning up unused Docker resources...")
	docker system prune -a --volumes

create_dirs:
	$(call print_blue, "Creating necessary directories...")
	if [ ! -d "$(DATA_DIR)/wordpress" ]; then mkdir -p $(DATA_DIR)/wordpress; fi
	if [ ! -d "$(DATA_DIR)/database_data" ]; then mkdir -p $(DATA_DIR)/database_data; fi
	if [ ! -d "$(DATA_DIR)/jekyll" ]; then mkdir -p $(DATA_DIR)/jekyll; fi

delete_data:
	$(call print_blue, "Deleting data directories...")
	sudo rm -rf $(DATA_DIR)

fclean: delete_data
	$(call print_blue, "Fully cleaning up Docker resources and deleting data directories...")
	docker stop $$(docker ps -qa); docker rm $$(docker ps -qa); docker rmi -f $$(docker images -qa); docker volume rm $$(docker volume ls -q); docker network rm $$(docker network ls -q) 2>/dev/null

.PHONY: build up down re clean fclean create_dirs delete_data