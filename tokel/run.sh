#!/bin/bash
set -euxo pipefail
tokeld -pubkey=${PUBKEY} &
cp /usr/local/bin/tokel-cli /home/komodian/.komodo/TOKEL/tokel-cli-bin
debug="/home/komodian/.komodo/TOKEL/debug.log"
if [ ! -f "$debug"  ]; then
    echo "" > $debug
fi
tail -f $debug
