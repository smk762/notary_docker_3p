#!/bin/bash
marmarad -pubkey=${PUBKEY} &
sleep 20
ls -la /home/komodian/.komodo/MCL
tail -f /home/komodian/.komodo/MCL/debug.log
