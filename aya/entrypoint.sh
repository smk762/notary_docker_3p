#!/bin/sh

username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
rpcpass=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)

mkdir -p ~/.aryacoin
echo "server=1" > ~/.aryacoin/aryacoin.conf
echo "listen=1" >> ~/.aryacoin/aryacoin.conf
echo "daemon=1" >> ~/.aryacoin/aryacoin.conf
echo "txindex=1" >> ~/.aryacoin/aryacoin.conf
echo "spentindex=1" >> ~/.aryacoin/aryacoin.conf
echo "addressindex=1" >> ~/.aryacoin/aryacoin.conf
echo "p2pport=41887" >> ~/.aryacoin/aryacoin.conf
echo "rpcport=41888" >> ~/.aryacoin/aryacoin.conf
echo "rpcuser=${username}" >> ~/.aryacoin/aryacoin.conf
echo "rpcpassword=${rpcpass}" >> ~/.aryacoin/aryacoin.conf
echo "rpcbind=127.0.0.1" >> ~/.aryacoin/aryacoin.conf
echo "rpcallowip=127.0.0.1" >> ~/.aryacoin/aryacoin.conf

# cat ~/.aryacoin/aryacoin.conf

exec "$@"
