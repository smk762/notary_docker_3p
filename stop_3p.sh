#!/bin/bash

if [ -z "$1" ]
  then
    docker compose stop
  else
    docker compose stop $1
fi

