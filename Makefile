all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	@docker compose -f ./srcs/docker-compose.yml up -d 

status:
	@docker ps

stoped:
	@docker ps -a

wp:
	@docker logs wordpress
nginx:
	@docker logs nginx
msb:
	@docker logs mariadb

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean: down
	@docker system prune -af
	@rm -rf /home/manugonz/data/mariadb/*
	@rm -rf /home/manugonz/data/wordpress/*

.PHONY: all up status stoped wp mdb nginx down clean