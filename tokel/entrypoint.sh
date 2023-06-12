#!/bin/sh

username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
rpcpass=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)

mkdir -p ~/.komodo/TOKEL
echo "server=1" > ~/.komodo/TOKEL/komodo.conf
echo "listen=1" >> ~/.komodo/TOKEL/komodo.conf
echo "daemon=1" >> ~/.komodo/TOKEL/komodo.conf
echo "txindex=1" >> ~/.komodo/TOKEL/komodo.conf
echo "spentindex=1" >> ~/.komodo/TOKEL/komodo.conf
echo "addressindex=1" >> ~/.komodo/TOKEL/komodo.conf
echo "p2pport=29404" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcport=29405" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcuser=${username}" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcpassword=${rpcpass}" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcbind=127.0.0.1" >> ~/.komodo/TOKEL/komodo.conf
echo "rpcallowip=127.0.0.1" >> ~/.komodo/TOKEL/komodo.conf

# cat ~/.komodo/komodo.conf

exec "$@"
