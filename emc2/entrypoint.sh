#!/bin/sh

username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
rpcpass=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)

mkdir -p ~/.einsteinium
echo "server=1" > ~/.einsteinium/einsteinium.conf
echo "listen=1" >> ~/.einsteinium/einsteinium.conf
echo "daemon=1" >> ~/.einsteinium/einsteinium.conf
echo "txindex=1" >> ~/.einsteinium/einsteinium.conf
echo "spentindex=1" >> ~/.einsteinium/einsteinium.conf
echo "addressindex=1" >> ~/.einsteinium/einsteinium.conf
echo "p2pport=41887" >> ~/.einsteinium/einsteinium.conf
echo "rpcport=41888" >> ~/.einsteinium/einsteinium.conf
echo "rpcuser=${username}" >> ~/.einsteinium/einsteinium.conf
echo "rpcpassword=${rpcpass}" >> ~/.einsteinium/einsteinium.conf
echo "rpcbind=127.0.0.1" >> ~/.einsteinium/einsteinium.conf
echo "rpcallowip=127.0.0.1" >> ~/.einsteinium/einsteinium.conf

# cat ~/.einsteinium/einsteinium.conf

exec "$@"
