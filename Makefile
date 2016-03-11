ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

#############################
# Create new project
#############################

create:
	bash bin/create-project.sh $(ARGS)

#############################
# Docker machine states
#############################

up:
	docker-compose up -d

start:
	docker-compose start

stop:
	docker-compose stop

state:
	docker-compose ps

rebuild:
	docker-compose stop
	docker-compose rm --force app
	docker-compose build --no-cache
	docker-compose up -d

#############################
# MySQL
#############################

mysql-backup:
	docker exec -it $$(docker-compose ps -q app) bash /docker/bin/backup.sh mysql

mysql-restore:
	docker exec -it $$(docker-compose ps -q app) bash /docker/bin/restore.sh mysql

#############################
# Solr
#############################

solr-backup:
	docker-compose stop solr
	docker exec -it $$(docker-compose ps -q app) bash /docker/bin/backup.sh solr
	docker-compose start solr

solr-restore:
	docker-compose stop solr
	docker exec -it $$(docker-compose ps -q app) bash /docker/bin/restore.sh solr
	docker-compose start solr

#############################
# General
#############################

backup:  mysql-backup  solr-backup
restore: mysql-restore solr-restore

build:
	bash bin/build.sh

clean:
	test -d app/typo3temp && { rm -rf app/typo3temp/*; }

bash:
	docker exec -it $$(docker-compose ps -q app) bash

root:
	docker exec -it $$(docker-compose ps -q app) bash

#############################
# TYPO3
#############################

scheduler:
	docker exec -it $$(docker-compose ps -q app) typo3/cli_dispatch.phpsh scheduler $(ARGS)

#############################
# Argument fix workaround
#############################
%:
	@:
