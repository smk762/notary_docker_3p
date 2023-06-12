#!/bin/sh

mkdir -p /home/komodian/.komodo
echo "server=1" > /home/komodian/.komodo/komodo.conf
echo "listen=1" >> /home/komodian/.komodo/komodo.conf
echo "daemon=1" >> /home/komodian/.komodo/komodo.conf
echo "txindex=1" >> /home/komodian/.komodo/komodo.conf
echo "spentindex=1" >> /home/komodian/.komodo/komodo.conf
echo "addressindex=1" >> /home/komodian/.komodo/komodo.conf
echo "p2pport=33824" >> /home/komodian/.komodo/komodo.conf
echo "rpcport=33825" >> /home/komodian/.komodo/komodo.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.komodo/komodo.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.komodo/komodo.conf
echo "rpcbind=127.0.0.1" >> /home/komodian/.komodo/komodo.conf
echo "rpcallowip=127.0.0.1" >> /home/komodian/.komodo/komodo.conf

exec "$@"
