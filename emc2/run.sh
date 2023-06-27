#!/bin/bash
set -euxo pipefail
einsteiniumd -pubkey=${PUBKEY} &
cp /usr/local/bin/einsteinium-cli /home/komodian/.einsteinium/einsteinium-cli
debug="/home/komodian/.einsteinium/debug.log"
if [ ! -f "$debug"  ]; then
    echo "" > $debug
fi
tail -f $debug
