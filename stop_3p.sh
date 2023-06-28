#!/bin/bash

set -x

source ./service_cli

if [[ -z ${1-} ]]; then
  for key in "${!service_cli[@]}"; do
    ${service_cli[$key]} stop
  done
  sleep 60
  docker compose stop
else
  ${service_cli[$1]} stop
  sleep 60
  docker compose stop $1
fi

set +x