
mkdir -p /home/komodian/.komodo/TOKEL
echo "server=1" > /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "listen=1" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "daemon=1" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "txindex=1" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "spentindex=1" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "addressindex=1" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "port=29404" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "rpcport=29405" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "rpcbind=0.0.0.0:29405" >> /home/komodian/.komodo/TOKEL/TOKEL.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.komodo/TOKEL/TOKEL.conf

echo "" > /home/komodian/.komodo/TOKEL/debug.log

echo "${COMMIT_HASH}" > /home/komodian/COMMIT_HASH

# cat /home/komodian/.komodo/TOKEL/TOKEL.conf
