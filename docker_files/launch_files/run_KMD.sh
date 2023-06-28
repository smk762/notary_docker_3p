#!/usr/bin/env bash
set -x

trap 'komodo-cli stop'  SIGHUP SIGINT SIGTERM

# Running KMD daemon

if ! [ -f /home/komodian/.komodo/debug.log ]; then
    echo "" > /home/komodian/.komodo/debug.log
fi

exec komodod -gen -genproclimit=1 -minrelaytxfee=0.000035 -opretmintxfee=0.004 -notary=.litecoin/litecoin.conf -pubkey=${PUBKEY} &
sleep 5
tail -f /home/komodian/.komodo/debug.log & wait

set +x