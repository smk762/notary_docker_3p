#!/usr/bin/env bash
set -x

trap 'marmara-cli stop'  SIGHUP SIGINT SIGTERM

# Running MCL daemon
exec marmarad -pubkey=${PUBKEY} &
tail -f /home/smk762/.komodo_3p/debug.log & wait

set +x