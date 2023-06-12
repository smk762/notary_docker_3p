#!/bin/bash
mild -pubkey=${PUBKEY} &
sleep 20
ls -la ~/.komodo/VRSC
tail -f ~/.komodo/VRSC/debug.log
