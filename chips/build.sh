#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/chips-blockchain/chips -b master
cd chips && git checkout ${COMMIT_HASH}

make -C ${PWD}/depends v=1 NO_PROTON=1 NO_QT=1 HOST=$(depends/config.guess) -j$(nproc --all)
./autogen.sh
CXXFLAGS="-g0 -O2" \
CONFIG_SITE="$PWD/depends/$(depends/config.guess)/share/config.site" ./configure --disable-tests --disable-bench --without-miniupnpc --enable-experimental-asm --with-gui=no --disable-bip70
make V=1 -j$(nproc --all)

mkdir -p /home/komodian/.chips
echo "server=1" > /home/komodian/.chips/chips.conf
echo "listen=1" >> /home/komodian/.chips/chips.conf
echo "daemon=1" >> /home/komodian/.chips/chips.conf
echo "txindex=1" >> /home/komodian/.chips/chips.conf
echo "spentindex=1" >> /home/komodian/.chips/chips.conf
echo "addressindex=1" >> /home/komodian/.chips/chips.conf
echo "p2pport=57777" >> /home/komodian/.chips/chips.conf
echo "rpcport=57776" >> /home/komodian/.chips/chips.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.chips/chips.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.chips/chips.conf
echo "rpcbind=127.0.0.1" >> /home/komodian/.chips/chips.conf
echo "rpcallowip=127.0.0.1" >> /home/komodian/.chips/chips.conf

echo "" > /home/komodian/.chips/debug.log
# cat /home/komodian/.chips/chips.conf
