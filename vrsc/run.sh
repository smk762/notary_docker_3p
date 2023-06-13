#!/bin/bash
verusd -pubkey=${PUBKEY} &
sleep 20
ls -la /home/komodian/.komodo/VRSC
tail -f /home/komodian/.komodo/VRSC/debug.log
