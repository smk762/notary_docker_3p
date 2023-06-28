#!/usr/bin/env bash
set -x

trap 'tokel-cli stop'  SIGHUP SIGINT SIGTERM

# Running TOKEL daemon

if ! [ -f /home/komodian/.komodo_3p/debug.log ]; then
    echo "" > /home/komodian/.komodo_3p/debug.log
fi

exec tokeld -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.komodo_3p/debug.log & wait

set +x