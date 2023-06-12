#!/bin/bash
echo $PWD
echo "========================================"
cd ~
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout ${COMMITHASH}
./zcutil/build.sh -j$(nproc)
