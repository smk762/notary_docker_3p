#!/usr/bin/env bash
set -x

trap 'mil-cli stop'  SIGHUP SIGINT SIGTERM

# Running MIL daemon
exec mild -pubkey=${PUBKEY} &
tail -f /home/smk762/.mil/debug.log & wait

set +x