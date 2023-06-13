#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/KomodoPlatform/AYAv2
cd AYAv2 && git checkout ${COMMIT_HASH}

make -C ${PWD}/depends v=1 NO_PROTON=1 NO_QT=1 HOST=$(depends/config.guess) -j$(nproc --all)
./autogen.sh
CXXFLAGS="-g0 -O2" \
CONFIG_SITE="$PWD/depends/$(depends/config.guess)/share/config.site" ./configure --disable-tests --disable-bench --without-miniupnpc --enable-experimental-asm --with-gui=no --disable-bip70
make V=1 -j$(nproc --all)

mkdir -p /home/komodian/.aryacoin
echo "server=1" > /home/komodian/.aryacoin/aryacoin.conf
echo "listen=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "daemon=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "txindex=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "spentindex=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "addressindex=1" >> /home/komodian/.aryacoin/aryacoin.conf
echo "port=26001" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcport=9332" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcbind=0.0.0.0:9332" >> /home/komodian/.aryacoin/aryacoin.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.aryacoin/aryacoin.conf

echo "" > /home/komodian/.aryacoin/debug.log
# cat /home/komodian/.aryacoin/aryacoin.conf
