#!/bin/bash
aryacoind -pubkey=${PUBKEY} &
sleep 20
ls -la ~/.aryacoin
tail -f ~/.aryacoin/debug.log
