#!/bin/bash

set -euo pipefail

# printf "Waiting for database to be ready"
# until docker-compose exec -T db /bin/bash -c 'mysql -h127.0.0.1 -uroot -p$MYSQL_ROOT_PASSWORD -e "SELECT 1"' &> /dev/null
# do
#   printf "."
#   sleep 1
# done
# docker-compose exec -T transform-db /bin/bash -c 'psql -d transform-db -h127.0.0.1 -Upostgres -Ppostgres -e "SELECT 1"'