#!/bin/bash
chipsd -pubkey=${PUBKEY} -addnode=5.9.253.195 &
sleep 20
ls -la /home/komodian/.chips
tail -f /home/komodian/.chips/debug.log
