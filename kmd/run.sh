#!/bin/bash
set -euxo pipefail
komodod -pubkey=${PUBKEY} -minrelaytxfee=0.000035 -opretmintxfee=0.004 &
cp /usr/local/bin/komodo-cli /home/komodian/.komodo/komodo-cli
tail -f /home/komodian/.komodo/debug.log
