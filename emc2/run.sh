#!/bin/bash
einsteiniumd -pubkey=${PUBKEY}
sleep 20
ls -la ~/.einsteinium
tail -f ~/.einsteinium/debug.log
