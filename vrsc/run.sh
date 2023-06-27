#!/bin/bash
set -euxo pipefail
verusd -pubkey=${PUBKEY} &
cp /usr/local/bin/verus /home/komodian/.komodo/VRSC/verus-cli-bin

debug="/home/komodian/.komodo/VRSC/debug.log"
if [ ! -f "$debug"  ]; then
    echo "" > $debug
fi
tail -f $debug

