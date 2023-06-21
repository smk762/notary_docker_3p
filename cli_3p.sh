#!/bin/bash

set -euxo pipefail

source ./service_cli

if [ -z "$2" ]
  then
    for key in "${!service_cli[@]}"; do
      ${service_cli[$key]} $1
    done
  else
    ${service_cli[$1]} $2
fi

