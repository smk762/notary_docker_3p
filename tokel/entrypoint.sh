#!/bin/sh

mkdir -p ~/.komodo/TOKEL
echo "server=1" > ~/.komodo/TOKEL/komodo.conf
echo "listen=1" >> ~/.komodo/TOKEL/komodo.conf
echo "daemon=1" >> ~/.komodo/TOKEL/komodo.conf
echo "txindex=1" >> ~/.komodo/TOKEL/komodo.conf
echo "spentindex=1" >> ~/.komodo/TOKEL/komodo.conf
echo "addressindex=1" >> ~/.komodo/TOKEL/komodo.conf
echo "p2pport=29404" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcport=29405" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcuser=${RPC_USER}" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcpassword=${RPC_PASS}" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcbind=127.0.0.1" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcallowip=127.0.0.1" >> ~/.komodo/TOKEL/komodo.conf

# cat ~/.komodo/komodo.conf

exec "$@"
