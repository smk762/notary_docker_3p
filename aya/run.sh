#!/bin/bash
set -euxo pipefail
aryacoind -pubkey=${PUBKEY} &
sleep 20
ls -la /home/komodian/.aryacoin
tail -f /home/komodian/.aryacoin/debug.log
