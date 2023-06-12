#!/bin/sh

mkdir -p ~/.einsteinium
echo "server=1" > ~/.einsteinium/einsteinium.conf
echo "listen=1" >> ~/.einsteinium/einsteinium.conf
echo "daemon=1" >> ~/.einsteinium/einsteinium.conf
echo "txindex=1" >> ~/.einsteinium/einsteinium.conf
echo "spentindex=1" >> ~/.einsteinium/einsteinium.conf
echo "addressindex=1" >> ~/.einsteinium/einsteinium.conf
echo "p2pport=41878" >> ~/.einsteinium/einsteinium.conf
echo "rpcport=41879" >> ~/.einsteinium/einsteinium.conf
echo "rpcuser=${RPC_USER}" >> ~/.einsteinium/einsteinium.conf
echo "rpcpassword=${RPC_PASS}" >> ~/.einsteinium/einsteinium.conf
echo "rpcbind=127.0.0.1" >> ~/.einsteinium/einsteinium.conf
echo "rpcallowip=127.0.0.1" >> ~/.einsteinium/einsteinium.conf

# cat ~/.einsteinium/einsteinium.conf

exec "$@"
