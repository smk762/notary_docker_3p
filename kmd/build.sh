#!/bin/bash
set -euxo pipefailecho $PWD
echo "========================================"
cd /home/komodian
git clone https://github.com/KomodoPlatform/komodo
cd komodo && git checkout ${COMMIT_HASH}
./zcutil/build.sh -j$(nproc)
