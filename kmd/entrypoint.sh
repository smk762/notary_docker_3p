#!/bin/sh

mkdir -p ~/.komodo
echo "server=1" > ~/.komodo/komodo.conf
echo "listen=1" >> ~/.komodo/komodo.conf
echo "daemon=1" >> ~/.komodo/komodo.conf
echo "txindex=1" >> ~/.komodo/komodo.conf
echo "spentindex=1" >> ~/.komodo/komodo.conf
echo "addressindex=1" >> ~/.komodo/komodo.conf
echo "p2pport=7770" >> ~/.komodo/komodo.conf
echo "rpcport=7771" >> ~/.komodo/komodo.conf
echo "rpcuser=${RPC_USER}" >> ~/.komodo/komodo.conf
echo "rpcpassword=${RPC_PASS}" >> ~/.komodo/komodo.conf
echo "rpcbind=127.0.0.1" >> ~/.komodo/komodo.conf
echo "rpcallowip=127.0.0.1" >> ~/.komodo/komodo.conf

# cat ~/.komodo/komodo.conf

exec "$@"
