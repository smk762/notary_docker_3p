#!/bin/sh

username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
rpcpass=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)

mkdir -p ~/.chips
echo "server=1" > ~/.chips/chips.conf
echo "listen=1" >> ~/.chips/chips.conf
echo "daemon=1" >> ~/.chips/chips.conf
echo "txindex=1" >> ~/.chips/chips.conf
echo "spentindex=1" >> ~/.chips/chips.conf
echo "addressindex=1" >> ~/.chips/chips.conf
echo "p2pport=57777" >> ~/.chips/chips.conf
echo "rpcport=57776" >> ~/.chips/chips.conf
echo "rpcuser=${username}" >> ~/.chips/chips.conf
echo "rpcpassword=${rpcpass}" >> ~/.chips/chips.conf
echo "rpcbind=127.0.0.1" >> ~/.chips/chips.conf
echo "rpcallowip=127.0.0.1" >> ~/.chips/chips.conf

# cat ~/.chips/chips.conf

exec "$@"
