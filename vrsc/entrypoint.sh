#!/bin/sh

mkdir -p ~/.komodo/VRSC
echo "server=1" > ~/.komodo/VRSC/VRSC.conf
echo "listen=1" >> ~/.komodo/VRSC/VRSC.conf
echo "daemon=1" >> ~/.komodo/VRSC/VRSC.conf
echo "txindex=1" >> ~/.komodo/VRSC/VRSC.conf
echo "spentindex=1" >> ~/.komodo/VRSC/VRSC.conf
echo "addressindex=1" >> ~/.komodo/VRSC/VRSC.conf
echo "p2pport=27485" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcport=27486" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcuser=${RPC_USER}" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcpassword=${RPC_PASS}" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcbind=127.0.0.1" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcallowip=127.0.0.1" >> ~/.komodo/VRSC/VRSC.conf

# cat ~/.komodo/VRSC/VRSC.conf

exec "$@"
