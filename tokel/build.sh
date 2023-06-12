#!/bin/bash
echo $PWD
echo "========================================"
cd ~
git clone https://github.com/TokelPlatform/tokel
cd tokel && git checkout ${COMMIT_HASH}
./zcutil/build.sh -j$(nproc)
