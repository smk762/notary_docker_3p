#!/bin/bash
set -euxo pipefailkomodod -pubkey=${PUBKEY} -minrelaytxfee=0.000035 -opretmintxfee=0.004 &
sleep 20
ls -la /home/komodian/.komodo
tail -f /home/komodian/.komodo/debug.log
