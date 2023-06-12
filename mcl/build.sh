#!/bin/bash
echo $PWD
echo "========================================"
cd ~
git clone https://github.com/marmarachain/marmara
cd marmara && git checkout ${COMMITHASH}
./zcutil/build.sh -j$(nproc)
