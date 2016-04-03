#!/bin/bash
set -e

# Edit the following three values to your liking:
REDIS_USER="jhana_dev"
REDIS_DATABASE="jhana_dev"
REDIS_CONTAINER_NAME="jhana_redis"

# Do not edit these values:
# (creates a 32 char password for the Redis root user and the Enterprise Registery DB user)
#REDIS_PASS=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | sed 1q
# It will provision a blank database for the Enterprise Registery upon first start.
echo "Start the Redis container:"

docker \
  run \
  --detach \
  --env REDIS_DATABASE=${REDIS_DATABASE} \
  --name ${REDIS_CONTAINER_NAME} \
  --publish 6379:6379 \
  redis:3.0.7;

echo "Sleeping for 10 seconds to allow time for the DB to be provisioned:"
for i in `seq 1 10`;
do
  echo "."
  sleep 1
done

echo "Database '${REDIS_DATABASE}' running."
echo "  Username: ${REDIS_USER}"
#echo "  Password: ${REDIS_PASS}"
