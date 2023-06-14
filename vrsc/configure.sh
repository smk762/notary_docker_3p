
mkdir -p /home/komodian/.komodo/VRSC
echo "server=1" > /home/komodian/.komodo/VRSC/VRSC.conf
echo "listen=1" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "daemon=1" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "txindex=1" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "spentindex=1" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "addressindex=1" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "port=27485" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "rpcport=27486" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "rpcbind=0.0.0.0:27486" >> /home/komodian/.komodo/VRSC/VRSC.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.komodo/VRSC/VRSC.conf

echo "" > /home/komodian/.komodo/VRSC/debug.log

echo "${COMMIT_HASH}" > /home/komodian/COMMIT_HASH

# cat /home/komodian/.komodo/VRSC/VRSC.conf