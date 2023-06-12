#!/bin/sh

username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
rpcpass=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)

mkdir -p ~/.komodo
echo "server=1" > ~/.komodo/komodo.conf
echo "listen=1" >> ~/.komodo/komodo.conf
echo "daemon=1" >> ~/.komodo/komodo.conf
echo "txindex=1" >> ~/.komodo/komodo.conf
echo "spentindex=1" >> ~/.komodo/komodo.conf
echo "addressindex=1" >> ~/.komodo/komodo.conf
echo "p2pport=41887" >> ~/.komodo/komodo.conf
echo "rpcport=41888" >> ~/.komodo/komodo.conf
echo "rpcuser=${username}" >> ~/.komodo/komodo.conf
echo "rpcpassword=${rpcpass}" >> ~/.komodo/komodo.conf
echo "rpcbind=127.0.0.1" >> ~/.komodo/komodo.conf
echo "rpcallowip=127.0.0.1" >> ~/.komodo/komodo.conf

exec "$@"
