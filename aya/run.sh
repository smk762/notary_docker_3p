#!/bin/bash
set -euxo pipefail
cp /usr/local/bin/aryacoin-cli /home/komodian/.aryacoin/aryacoin-cli
aryacoind -pubkey=${PUBKEY} &

debug="/home/komodian/.aryacoin/debug.log"
if [ ! -f "$debug"  ]; then
    echo "" > $debug
fi
tail -f $debug
