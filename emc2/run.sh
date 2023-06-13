#!/bin/bash
set -euxo pipefaileinsteiniumd -pubkey=${PUBKEY} &
sleep 20
ls -la /home/komodian/.einsteinium
tail -f /home/komodian/.einsteinium/debug.log
