#!/bin/bash
echo $PWD
echo "========================================"
cd ~
git clone https://github.com/VerusCoin/VerusCoin
cd VerusCoin && git checkout ${COMMITHASH}
./zcutil/build.sh -j$(nproc)
