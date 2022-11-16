DOCKER_COMPOSE = docker-compose -f docker-compose.yml

db-setup:
	${DOCKER_COMPOSE} up -d transform-db
	${DOCKER_COMPOSE} up -d replica-db

build:
	${DOCKER_COMPOSE} build

serve: 
	${DOCKER_COMPOSE} up -d etl-process

stop:
	${DOCKER_COMPOSE} down

redo: stop build db-setup

logs:
	docker-compose logs -f etl-process

shell-transform:
	docker exec -it transformation sh

shell:
	docker exec -it etl-process sh