#!/bin/bash
# A simple shell script to provision a dedicated MySQL container for the CoreOS Enterprise Registery
set -e

# Edit the following three values to your liking:
MYSQL_USER="jhana_dev"
MYSQL_DATABASE="jhana_dev"
MYSQL_CONTAINER_NAME="jhana_mysql"

# Do not edit these values:
# (creates a 32 char password for the MySQL root user and the Enterprise Registery DB user)
MYSQL_ROOT_PASSWORD="jhana_root"
#MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | sed 1q)
#MYSQL_PASSWORD=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | sed 1q)
MYSQL_PASSWORD="jhana_pass"

echo "Start the Oracle MySQL container:"
# It will provision a blank database for the Enterprise Registery upon first start.
# This initial provisioning can take up to 30 seconds.

docker \
  run \
  --detach \
  --env MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
  --env MYSQL_USER=${MYSQL_USER} \
  --env MYSQL_PASSWORD=${MYSQL_PASSWORD} \
  --env MYSQL_DATABASE=${MYSQL_DATABASE} \
  --name ${MYSQL_CONTAINER_NAME} \
  --publish 3306:3306 \
  mysql:5.7;

echo "Sleeping for 10 seconds to allow time for the DB to be provisioned:"
for i in `seq 1 10`;
do
  echo "."
  sleep 1
done

echo "Database '${MYSQL_DATABASE}' running."
echo "  Username: ${MYSQL_USER}"
echo "  Password: ${MYSQL_PASSWORD}"
