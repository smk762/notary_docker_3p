#!/bin/sh

username=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)
rpcpass=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -n 1)

mkdir -p ~/.komodo/VRSC
echo "server=1" > ~/.komodo/VRSC/VRSC.conf
echo "listen=1" >> ~/.komodo/VRSC/VRSC.conf
echo "daemon=1" >> ~/.komodo/VRSC/VRSC.conf
echo "txindex=1" >> ~/.komodo/VRSC/VRSC.conf
echo "spentindex=1" >> ~/.komodo/VRSC/VRSC.conf
echo "addressindex=1" >> ~/.komodo/VRSC/VRSC.conf
echo "p2pport=27485" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcport=27486" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcuser=${username}" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcpassword=${rpcpass}" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcbind=127.0.0.1" >> ~/.komodo/VRSC/VRSC.conf
echo "rpcallowip=127.0.0.1" >> ~/.komodo/VRSC/VRSC.conf

# cat ~/.komodo/VRSC/VRSC.conf

exec "$@"
