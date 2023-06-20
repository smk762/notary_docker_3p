#!/bin/bash
set -euxo pipefail
chipsd -pubkey=${PUBKEY} -addnode=5.9.253.195 &
cp /usr/local/bin/chips-cli /home/komodian/.chips/chips-cli
tail -f /home/komodian/.chips/debug.log
