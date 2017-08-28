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
	docker-compose pull
	docker-compose rm --force app
	docker-compose build --no-cache --pull
	docker-compose up -d --force-recreate

#############################
# MySQL
#############################

mysql-backup:
	bash ./bin/backup.sh mysql

mysql-restore:
	bash ./bin/restore.sh mysql

#############################
# Solr
#############################

solr-backup:
	bash ./bin/backup.sh solr

solr-restore:
	bash ./bin/restore.sh solr

#############################
# General
#############################

backup:  mysql-backup  solr-backup
restore: mysql-restore solr-restore

build:
	bash bin/build.sh

clean:
	test -d app/typo3temp && { rm -rf app/typo3temp/*; }

bash: shell

shell:
	docker-compose exec --user application app /bin/bash

root:
	docker-compose exec --user root app /bin/bash

#############################
# TYPO3
#############################

cli:
	docker-compose run --rm --user application app cli $(ARGS)

scheduler:
	# TODO: remove the workaround "; (exit $?)" when https://github.com/docker/compose/issues/3379 has been fixed
	docker-compose exec --user application app /bin/bash -c '"$$WEB_DOCUMENT_ROOT"typo3/cli_dispatch.phpsh scheduler $(ARGS); (exit $$?)'

#############################
# Argument fix workaround
#############################
%:
	@:
