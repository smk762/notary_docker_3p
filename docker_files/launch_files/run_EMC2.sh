#!/usr/bin/env bash
set -x

trap 'einsteinium-cli stop'  SIGHUP SIGINT SIGTERM

# Running EMC2 daemon
exec einsteiniumd -pubkey=${PUBKEY} &
tail -f /home/smk762/.einsteinium/debug.log & wait

set +x