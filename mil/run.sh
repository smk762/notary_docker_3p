#!/bin/bash
mild -pubkey=${PUBKEY} &
sleep 20
ls -la ~/.mil
tail -f ~/.mil/debug.log
