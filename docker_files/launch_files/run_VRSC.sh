#!/usr/bin/env bash
set -x

trap 'verus-cli stop'  SIGHUP SIGINT SIGTERM

# Running VRSC daemon
exec verusd -pubkey=${PUBKEY} &
tail -f /home/smk762/.komodo_3p/debug.log & wait

set +x