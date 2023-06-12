#!/bin/sh

mkdir -p /home/komodian/.aryacoin
echo "server=1" > /home/komodian/.aryacoin/aryacoin.conf
echo "listen=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "daemon=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "txindex=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "spentindex=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "addressindex=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "p2pport=26001" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcport=9332" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcbind=127.0.0.1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcallowip=127.0.0.1" >> /home/komodian/.aryacoin/aryacoin.conf

# cat /home/komodian/.aryacoin/aryacoin.conf

exec "$@"
