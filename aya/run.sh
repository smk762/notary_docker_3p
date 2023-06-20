#!/bin/bash
set -euxo pipefail
cp /usr/local/bin/aryacoin-cli /home/komodian/.aryacoin/aryacoin-cli
aryacoind -pubkey=${PUBKEY} &
tail -f /home/komodian/.aryacoin/debug.log
