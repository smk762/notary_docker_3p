#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout ${COMMIT_HASH}
./zcutil/build.sh -j$(nproc)

mkdir -p /home/komodian/.komodo
echo "server=1" > /home/komodian/.komodo/komodo.conf
echo "listen=1" >> /home/komodian/.komodo/komodo.conf
echo "daemon=1" >> /home/komodian/.komodo/komodo.conf
echo "txindex=1" >> /home/komodian/.komodo/komodo.conf
echo "spentindex=1" >> /home/komodian/.komodo/komodo.conf
echo "addressindex=1" >> /home/komodian/.komodo/komodo.conf
echo "port=8770" >> /home/komodian/.komodo/komodo.conf
echo "rpcport=8771" >> /home/komodian/.komodo/komodo.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.komodo/komodo.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.komodo/komodo.conf
echo "rpcbind=127.0.0.1:8771" >> /home/komodian/.komodo/komodo.conf
echo "rpcallowip=127.0.0.1" >> /home/komodian/.komodo/komodo.conf

echo "" > /home/komodian/.komodo/debug.log
# cat /home/komodian/.komodo/komodo.conf
