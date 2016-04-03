#!/bin/bash
set -e

# Edit the following three values to your liking:
MONGODB_USER="jhana_dev"
MONGODB_DATABASE="jhana_dev"
MONGODB_CONTAINER_NAME="jhana_mongo"

# Do not edit these values:
# (creates a 32 char password for the MongoDB root user and the Enterprise Registery DB user)
#MONGODB_PASS=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | sed 1q)

echo "Start the MongoDB container:"
# It will provision a blank database for the Enterprise Registery upon first start.
# This initial provisioning can take up to 30 seconds.

docker \
  run \
  --detach \
  --env MOGNODB_DATABASE=${MONGODB_DATABASE} \
  --name ${MONGODB_CONTAINER_NAME} \
  --publish 27017:27017 \
  mongo:3.2.4;

echo "Sleeping for 10 seconds to allow time for the DB to be provisioned:"
for i in `seq 1 10`;
do
  echo "."
  sleep 1
done

echo "Database '${MONGODB_DATABASE}' running."
echo "  Username: ${MONGODB_USER}"
#echo "  Password: ${MONGODB_PASS}"
