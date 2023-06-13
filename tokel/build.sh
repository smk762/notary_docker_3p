#!/bin/bash
set -euxo pipefailecho $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/TokelPlatform/tokel
cd tokel && git checkout ${COMMIT_HASH}
./zcutil/build.sh -j$(nproc)
