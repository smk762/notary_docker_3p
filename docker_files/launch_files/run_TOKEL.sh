#!/usr/bin/env bash
set -x

trap 'tokel-cli stop'  SIGHUP SIGINT SIGTERM

# Running TOKEL daemon
exec tokeld -pubkey=${PUBKEY} &
tail -f /home/smk762/.komodo_3p/debug.log & wait

set +x