#!/usr/bin/env bash
set -x

trap 'chips-cli stop'  SIGHUP SIGINT SIGTERM

# Running CHIPS daemon

if ! [ -f /home/komodian/.chips/debug.log ]; then
    echo "" > /home/komodian/.chips/debug.log
fi

exec chipsd -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.chips/debug.log & wait

set +x