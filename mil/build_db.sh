#!/bin/bash
set -euxo pipefail
echo $PWD
echo "========================================"
mkdir -p /opt/${BERKELEYDB_PREFIX}
cd /opt/${BERKELEYDB_PREFIX}
BERKELEYDB_VERSION=db-4.8.30.NC
BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}
wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz
tar -xzf *.tar.gz
sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h

cd /${BERKELEYDB_VERSION}/build_unix
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
make -j4
make install
rm -rf ${BERKELEYDB_PREFIX}/docs
