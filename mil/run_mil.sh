#!/bin/bash
mild -printtoconsole -conf=/root/.mil/mil.conf -datadir=/root/.mil -pubkey=${PUBKEY}
ls -la ~/.mil
sleep 20
ls -la ~/.mil
tail -f ~/.mil/debug.log