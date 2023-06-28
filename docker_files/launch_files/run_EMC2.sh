#!/usr/bin/env bash
set -x

trap 'einsteinium-cli stop'  SIGHUP SIGINT SIGTERM

# Running EMC2 daemon

if ! [ -f /home/komodian/.einsteinium/debug.log ]; then
    echo "" > /home/komodian/.einsteinium/debug.log
fi

exec einsteiniumd -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.einsteinium/debug.log & wait

set +x