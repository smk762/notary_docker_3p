#!/bin/bash

echo "Updating repository..."
git pull

echo "Updating docker-compose.yml..."
rm docker-compose.yml
cp docker-compose.template docker-compose.yml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"

if [ -z "$1" ]
  then
    echo "Building docker images..."
    docker compose build $@
    ./stop_3p.sh
    ./start_3p.sh
  else
    echo "Building docker image: $1"
    docker compose build $1 $@
    ./stop_3p.sh $1
    ./start_3p.sh $1 
fi
