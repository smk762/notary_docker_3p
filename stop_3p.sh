#!/bin/bash

set -euxo pipefail

source ./service_cli

if [ -z "$1" ]; then
  for key in "${!service_cli[@]}"; do
    ${service_cli[$key]} stop
  done
  docker compose stop
else
  ${service_cli[$i]} stop
  docker compose stop $1
fi

