#!/bin/bash
set -euxo pipefail
komodod -pubkey=${PUBKEY} -minrelaytxfee=0.000035 -opretmintxfee=0.004 -notary &
cp /usr/local/bin/komodo-cli /home/komodian/.komodo/komodo-cli

debug="/home/komodian/.komodo/debug.log"
if [ ! -f "$debug"  ]; then
    echo "" > $debug
fi
tail -f $debug
