#!/bin/bash
chipsd -pubkey=${PUBKEY} -addnode=5.9.253.195 &
sleep 20
ls -la ~/.chips
tail -f ~/.chips/debug.log
