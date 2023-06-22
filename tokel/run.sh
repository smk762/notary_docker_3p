#!/bin/bash
set -euxo pipefail
tokeld -pubkey=${PUBKEY} &
cp /usr/local/bin/tokel-cli /home/komodian/.komodo/TOKEL/tokel-cli-bin
tail -f /home/komodian/.komodo/TOKEL/debug.log
