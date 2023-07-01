#!/bin/bash
set -euxo pipefail
echo "========================================"
ROOT_PATH=$(pwd)
BDB_PREFIX="${ROOT_PATH}/db4"
BDB_VERSION=db-4.8.30.NC
BDB_SHA='12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef'
mkdir -p ${BDB_PREFIX}
cd ${BDB_PREFIX}
wget https://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
echo "${BDB_SHA}  ${BDB_VERSION}.tar.gz" | sha256sum -c
tar -xzf ${BDB_VERSION}.tar.gz

sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BDB_PREFIX}/${BDB_VERSION}/dbinc/atomic.h
cd ${BDB_PREFIX}/${BDB_VERSION}/build_unix

../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BDB_PREFIX}
make -j2
make install
rm -rf ${BDB_PREFIX}/${BDB_VERSION}/docs
