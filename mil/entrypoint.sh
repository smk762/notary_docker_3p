#!/bin/sh

mkdir -p ~/.mil
echo "server=1" > ~/.mil/mil.conf
echo "listen=1" >> ~/.mil/mil.conf
echo "daemon=1" >> ~/.mil/mil.conf
echo "txindex=1" >> ~/.mil/mil.conf
echo "spentindex=1" >> ~/.mil/mil.conf
echo "addressindex=1" >> ~/.mil/mil.conf
echo "p2pport=41888" >> ~/.mil/mil.conf
echo "rpcport=41889" >> ~/.mil/mil.conf
echo "rpcuser=${RPC_USER}" >> ~/.mil/mil.conf
echo "rpcpassword=${RPC_PASS}" >> ~/.mil/mil.conf
echo "rpcbind=127.0.0.1" >> ~/.mil/mil.conf
echo "rpcallowip=127.0.0.1" >> ~/.mil/mil.conf

# cat ~/.mil/mil.conf

exec "$@"
