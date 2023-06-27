#!/bin/bash
set -euxo pipefail
mild -pubkey=${PUBKEY} &
cp /usr/local/bin/mil-cli /home/komodian/.mil/mil-cli
debug="/home/komodian/.mil/debug.log"
if [ ! -f "$debug"  ]; then
    echo "" > $debug
fi
tail -f $debug
