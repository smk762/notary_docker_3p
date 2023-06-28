#!/usr/bin/env bash
set -x

trap 'aryacoin-cli stop'  SIGHUP SIGINT SIGTERM

# Running AYA daemon
exec aryacoind -pubkey=${PUBKEY} &
tail -f /home/smk762/.komodo/debug.log & wait

set +x