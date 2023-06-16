#!/bin/bash
set -euxo pipefail
einsteiniumd -pubkey=${PUBKEY} &
cp /usr/local/bin/einsteinium-cli /home/komodian/.einsteinium/einsteinium-cli
tail -f /home/komodian/.einsteinium/debug.log
