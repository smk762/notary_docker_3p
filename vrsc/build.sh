#!/bin/bash
echo $PWD
echo "========================================"
git clone https://github.com/VerusCoin/VerusCoin
cd VerusCoin && git checkout master && ./zcutil/build.sh -j$(nproc)
