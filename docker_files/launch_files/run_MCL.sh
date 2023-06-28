#!/usr/bin/env bash
set -x

trap 'marmara-cli stop'  SIGHUP SIGINT SIGTERM

# Running MCL daemon

if ! [ -f /home/komodian/.komodo_3p/debug.log ]; then
    echo "" > /home/komodian/.komodo_3p/debug.log
fi

exec marmarad -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.komodo_3p/debug.log & wait

set +x