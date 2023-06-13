#!/bin/bash
tokeld -pubkey=${PUBKEY} &
sleep 20
ls -la /home/komodian/.komodo/TOKEL
tail -f /home/komodian/.komodo/TOKEL/debug.log
