#!/bin/bash
marmarad -pubkey=${PUBKEY} &
sleep 20
ls -la ~/.komodo/MCL
tail -f ~/.komodo/MCL/debug.log
