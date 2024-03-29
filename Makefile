docker_compose_file=docker/docker-compose.yml
env_file=stress-test.env
#composer_file=src/composer.json

up:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) up -d

down:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) down -v --remove-orphans

stop:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) stop

logs:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) logs -f

ps:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) ps

rebuild:
	@echo "\033[32mRebuild containers...\033[0m"
	docker-compose --env-file $(env_file) -f $(docker_compose_file) build --force-rm --no-cache

php:
	@echo "\033[32mEntering into php container...\033[0m"
	docker-compose --env-file $(env_file) -f $(docker_compose_file) exec php bash

db:
	@echo "\033[32mEntering into DB container...\033[0m"
	docker-compose --env-file $(env_file) -f $(docker_compose_file) exec db bash

nginx:
	@echo "\033[32mEntering into nginx container...\033[0m"
	docker-compose --env-file $(env_file) -f $(docker_compose_file) exec nginx bash

stest-no-cache:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c10 -f /work/urls-not-cached.txt
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c25 -f /work/urls-not-cached.txt
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c50 -f /work/urls-not-cached.txt
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c100 -f /work/urls-not-cached.txt

stest-cache:
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c10 -f /work/urls-cached.txt
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c25 -f /work/urls-cached.txt
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c50 -f /work/urls-cached.txt
	docker-compose --env-file $(env_file) -f $(docker_compose_file) run siege -b -t60s -c100 -f /work/urls-cached.txt
