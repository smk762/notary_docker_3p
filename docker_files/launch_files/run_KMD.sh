#!/usr/bin/env bash
set -x

trap 'komodo-cli stop'  SIGHUP SIGINT SIGTERM

# Running KMD daemon
exec komodod -gen -genproclimit=1 -minrelaytxfee=0.000035 -opretmintxfee=0.004 -notary=.litecoin/litecoin.conf -pubkey=${PUBKEY} &
tail -f /home/smk762/.komodo/debug.log & wait

set +x