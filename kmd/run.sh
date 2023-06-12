#!/bin/bash
komodod -pubkey=${PUBKEY} -minrelaytxfee=0.000035 -opretmintxfee=0.004 &
sleep 20
ls -la ~/.komodo
tail -f ~/.komodo/debug.log
