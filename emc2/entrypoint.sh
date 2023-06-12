#!/bin/sh

mkdir -p /home/komodian/.einsteinium
echo "server=1" > /home/komodian/.einsteinium/einsteinium.conf
echo "listen=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "daemon=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "txindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "spentindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "addressindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "p2pport=41878" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcport=41879" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcbind=127.0.0.1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcallowip=127.0.0.1" >> /home/komodian/.einsteinium/einsteinium.conf

# cat /home/komodian/.einsteinium/einsteinium.conf

exec "$@"
