#!/bin/bash
echo $PWD
echo "========================================"
git clone https://github.com/marmarachain/marmara
cd marmara && git checkout master && ./zcutil/build.sh -j$(nproc)
