#!/bin/bash

if [ -z "$1" ]
  then
    echo "Restarting docker images..."
    ./stop_3p.sh
    ./start_3p.sh
  else
    echo "Restarting docker image: $1"
    ./stop_3p.sh $1
    ./start_3p.sh $1 
fi
