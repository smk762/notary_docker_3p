#!/bin/bash
set -euxo pipefail
mild -pubkey=${PUBKEY} &
sleep 20
ls -la /home/komodian/.mil
tail -f /home/komodian/.mil/debug.log
