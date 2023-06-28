#!/usr/bin/env bash
set -x

trap 'mil-cli stop'  SIGHUP SIGINT SIGTERM

# Running MIL daemon

if ! [ -f /home/komodian/.mil/debug.log ]; then
    echo "" > /home/komodian/.mil/debug.log
fi

exec mild -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.mil/debug.log & wait

set +x