#!/usr/bin/env bash
set -x

trap 'chips-cli stop'  SIGHUP SIGINT SIGTERM

# Running CHIPS daemon
exec chipsd -pubkey=${PUBKEY} &
tail -f /home/smk762/.chips/debug.log & wait

set +x