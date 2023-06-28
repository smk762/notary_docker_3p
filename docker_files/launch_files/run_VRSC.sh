#!/usr/bin/env bash
set -x

trap 'verus-cli stop'  SIGHUP SIGINT SIGTERM

# Running VRSC daemon

if ! [ -f /home/komodian/.komodo_3p/debug.log ]; then
    echo "" > /home/komodian/.komodo_3p/debug.log
fi

exec verusd -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.komodo_3p/debug.log & wait

set +x