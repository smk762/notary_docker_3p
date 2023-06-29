#!/bin/bash

if [ -z "$1" ]
  then
    docker compose logs -f --tail=20
  else
    docker compose logs -f $1 --tail=20
fi

