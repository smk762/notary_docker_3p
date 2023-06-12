#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/VerusCoin/VerusCoin
cd VerusCoin && git checkout ${COMMIT_HASH}
./zcutil/build.sh -j$(nproc)
