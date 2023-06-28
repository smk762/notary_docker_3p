#!/bin/bash

echo "Updating repository..."
git pull

echo "Setting launch files..."
./configure.py launch

echo "Updating docker-compose.yml..."
./configure.py yaml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"

echo "Setting up conf files and data folders..."
./configure.py confs

echo "Setting up cli wrappers..."
./configure.py clis


if [[ "$1" == "nobuild" ]]; then
    echo "Not building docker images..."
    exit 0
fi

if [ -z "$1" ]; then
    echo "Building docker images..."
    docker compose build $@
    ./stop_3p.sh
  else
    echo "Building docker image: $1"
    docker compose build $1 $@
    ./stop_3p.sh $1
fi

echo "Setting up cli wrapper symlinks (needs sudo)..."
./link_clis.sh

echo "Done! Use `start_3p.sh` to launch your daemons..."
