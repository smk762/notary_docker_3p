#!/bin/bash
set -euxo pipefail

if [ -z "$1" ]
  then
    docker compose stop
  else
    docker compose stop $1
fi

