#!/bin/bash
komodod -pubkey=${PUBKEY} &
sleep 20
ls -la ~/.komodo/TOKEL
tail -f ~/.komodo/TOKEL/debug.log
