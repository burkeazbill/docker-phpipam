#!/bin/bash
docker build -t burkeazbill/docker-phpipam .

## Notes:
# initial config completed and db dumpbed with following command:
# mysqldump -h mariadb phpipam -u phpipam -p > /ssl/MIGRATE.sql 
# From phpipam server, had to install mysql-client first