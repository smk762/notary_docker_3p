#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
BERKELEYDB_VERSION=db-4.8.30.NC
BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}
wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz
tar -xzf *.tar.gz
sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h
mkdir -p ${BERKELEYDB_PREFIX}
cd /${BERKELEYDB_VERSION}/build_unix
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
make -j4
make install
rm -rf ${BERKELEYDB_PREFIX}/docs

git clone https://github.com/emc2foundation/mil
cd mil && git checkout ${COMMIT_HASH}

make -C ${PWD}/depends v=1 NO_PROTON=1 NO_QT=1 HOST=$(depends/config.guess) -j$(nproc --all)
./autogen.sh
CXXFLAGS="-g0 -O2" \
CONFIG_SITE="$PWD/depends/$(depends/config.guess)/share/config.site" ./configure --disable-tests --disable-bench --without-miniupnpc --enable-experimental-asm --with-gui=no --disable-bip70
make V=1 -j$(nproc --all)

mkdir -p /home/komodian/.mil
echo "server=1" > /home/komodian/.mil/mil.conf
echo "listen=1" >> /home/komodian/.mil/mil.conf
echo "daemon=1" >> /home/komodian/.mil/mil.conf
echo "txindex=1" >> /home/komodian/.mil/mil.conf
echo "spentindex=1" >> /home/komodian/.mil/mil.conf
echo "addressindex=1" >> /home/komodian/.mil/mil.conf
echo "port=41888" >> /home/komodian/.mil/mil.conf
echo "rpcport=41889" >> /home/komodian/.mil/mil.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.mil/mil.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.mil/mil.conf
echo "rpcbind=127.0.0.1:41889" >> /home/komodian/.mil/mil.conf
echo "rpcallowip=127.0.0.1" >> /home/komodian/.mil/mil.conf

echo "" > /home/komodian/.mil/debug.log

# cat /home/komodian/.mil/mil.conf