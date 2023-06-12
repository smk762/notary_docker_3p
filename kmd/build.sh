#!/bin/bash
echo $PWD
echo "========================================"
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout master && ./zcutil/build.sh -j$(nproc)
