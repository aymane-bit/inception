COMPOSE     = docker compose -p inception -f srcs/docker-compose.yml
DATA_DIR    = /home/akajjou/data

all: setup build up
	@echo "Inception is running!"
	@echo "WordPress: https://akajjou.42.fr"

setup:
	@echo "Creating data directories..."
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress
	chmod -R 755 $(DATA_DIR)
	@echo "Data directories created"

build:
	@echo "Building Docker images..."
	@$(COMPOSE) build
	@echo "Build complete"

up:
	@echo "Starting services..."
	@$(COMPOSE) up -d --no-build
	@echo "Services started"

down:
	@echo "Stopping services..."
	@$(COMPOSE) down
	@echo "Services stopped"

stop:
	@echo "Stopping containers..."
	@$(COMPOSE) stop
	@echo "Containers stopped"

start:
	@echo "Starting containers..."
	@$(COMPOSE) start
	@echo "Containers started"

restart: stop start
	@echo "Services restarted"

status:
	@echo "Service status:"
	@$(COMPOSE) ps

logs:
	@$(COMPOSE) logs

logs-mariadb:
	@$(COMPOSE) logs mariadb

logs-wordpress:
	@$(COMPOSE) logs wordpress

logs-nginx:
	@$(COMPOSE) logs nginx

clean: down
	@echo "Cleaning up containers and images for this project..."
	@docker image prune -f
	@echo "Cleanup complete"

fclean: down
	@echo "Full cleanup - removing everything for this project..."
	@$(COMPOSE) down -v --rmi all --remove-orphans 2>/dev/null || true
	@docker volume prune -f 2>/dev/null || true
	@rm -rf $(DATA_DIR)
	@echo "Full cleanup complete"

re: fclean all