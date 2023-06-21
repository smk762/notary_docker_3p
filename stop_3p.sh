#!/bin/bash

set -euxo pipefail

source ./service_cli

arg=$1

if [ -z "$arg" ]; then
  for key in "${!service_cli[@]}"; do
    ${service_cli[$key]} stop
  done
  docker compose stop
else
  ${service_cli[$arg]} stop
  docker compose stop $arg
fi

