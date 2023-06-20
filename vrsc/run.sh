#!/bin/bash
set -euxo pipefail
verusd -pubkey=${PUBKEY} &
cp /usr/local/bin/verus /home/komodian/.komodo/VRSC/verus-cli
tail -f /home/komodian/.komodo/VRSC/debug.log
