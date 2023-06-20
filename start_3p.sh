#!/bin/bash

if [ -z "$1" ]
  then
    docker compose up -d && docker compose logs -f --tail 20
  else
    docker compose up $1 -d && docker compose logs $1 -f --tail 20
fi

