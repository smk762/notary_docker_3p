#!/bin/bash
set -euxo pipefail

git pull

rm docker-compose.yml
cp docker-compose.template docker-compose.yml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"
