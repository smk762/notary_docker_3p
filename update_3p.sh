#!/bin/bash

echo "Updating repository..."
git pull

echo "Updating docker-compose.yml..."
rm docker-compose.yml
cp docker-compose.template docker-compose.yml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"

echo "Building docker images..."
docker compose build
