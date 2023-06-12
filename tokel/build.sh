#!/bin/bash
echo $PWD
echo "========================================"
cd ~
git clone https://github.com/TokelPlatform/tokel
cd tokel && git checkout ${COMMITHASH}
./zcutil/build.sh -j$(nproc)
