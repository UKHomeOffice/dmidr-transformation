DOCKER_COMPOSE = docker-compose -f docker-compose.yml

db-setup:
	${DOCKER_COMPOSE} up -d transform-db
	${DOCKER_COMPOSE} up -d replica-db
	./scripts/wait_for_db.sh

build:
	${DOCKER_COMPOSE} build

serve: stop db-setup
	${DOCKER_COMPOSE} up -d etl-process

stop:
	${DOCKER_COMPOSE} down

logs:
	docker-compose logs -f etl-process

shell:
	${DOCKER_COMPOSE} run -rm etl-process sh