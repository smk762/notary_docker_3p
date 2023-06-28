#!/usr/bin/env bash
set -x

trap 'aryacoin-cli stop'  SIGHUP SIGINT SIGTERM

# Running AYA daemon

if ! [ -f /home/komodian/.komodo/debug.log ]; then
    echo "" > /home/komodian/.komodo/debug.log
fi

exec aryacoind -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.komodo/debug.log & wait

set +x