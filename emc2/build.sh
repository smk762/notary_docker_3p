#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/emc2foundation/einsteinium
cd einsteinium && git checkout ${COMMIT_HASH}

make -C ${PWD}/depends v=1 NO_PROTON=1 NO_QT=1 HOST=$(depends/config.guess) -j$(nproc --all)
./autogen.sh
CXXFLAGS="-g0 -O2" \
CONFIG_SITE="$PWD/depends/$(depends/config.guess)/share/config.site" ./configure --disable-tests --disable-bench --without-miniupnpc --enable-experimental-asm --with-gui=no --disable-bip70
make V=1 -j$(nproc --all)

mkdir -p /home/komodian/.einsteinium
echo "server=1" > /home/komodian/.einsteinium/einsteinium.conf
echo "listen=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "daemon=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "txindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "spentindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "addressindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "port=41878" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcport=41879" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcbind=0.0.0.0:41879" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.einsteinium/einsteinium.conf

echo "" > /home/komodian/.einsteinium/debug.log

# cat /home/komodian/.einsteinium/einsteinium.conf
