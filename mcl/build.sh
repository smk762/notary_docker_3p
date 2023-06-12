#!/bin/bash
echo $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/marmarachain/marmara
cd marmara && git checkout ${COMMIT_HASH}
./zcutil/build.sh -j$(nproc)
