#!/bin/sh

mkdir -p ~/.aryacoin
echo "server=1" > ~/.aryacoin/aryacoin.conf
echo "listen=1" >> ~/.aryacoin/aryacoin.conf
echo "daemon=1" >> ~/.aryacoin/aryacoin.conf
echo "txindex=1" >> ~/.aryacoin/aryacoin.conf
echo "spentindex=1" >> ~/.aryacoin/aryacoin.conf
echo "addressindex=1" >> ~/.aryacoin/aryacoin.conf
echo "p2pport=26001" >> ~/.aryacoin/aryacoin.conf
echo "rpcport=9332" >> ~/.aryacoin/aryacoin.conf
echo "rpcuser=${RPC_USER}" >> ~/.aryacoin/aryacoin.conf
echo "rpcpassword=${RPC_PASS}" >> ~/.aryacoin/aryacoin.conf
echo "rpcbind=127.0.0.1" >> ~/.aryacoin/aryacoin.conf
echo "rpcallowip=127.0.0.1" >> ~/.aryacoin/aryacoin.conf

# cat ~/.aryacoin/aryacoin.conf

exec "$@"
