#!/bin/bash
set -euxo pipefail
mild -pubkey=${PUBKEY} &
cp /usr/local/bin/mil-cli /home/komodian/.mil/mil-cli
tail -f /home/komodian/.mil/debug.log
