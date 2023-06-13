
mkdir -p /home/komodian/.komodo/MCL
echo "server=1" > /home/komodian/.komodo/MCL/MCL.conf
echo "listen=1" >> /home/komodian/.komodo/MCL/MCL.conf
echo "daemon=1" >> /home/komodian/.komodo/MCL/MCL.conf
echo "txindex=1" >> /home/komodian/.komodo/MCL/MCL.conf
echo "spentindex=1" >> /home/komodian/.komodo/MCL/MCL.conf
echo "addressindex=1" >> /home/komodian/.komodo/MCL/MCL.conf
echo "port=33824" >> /home/komodian/.komodo/MCL/MCL.conf
echo "rpcport=33825" >> /home/komodian/.komodo/MCL/MCL.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.komodo/MCL/MCL.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.komodo/MCL/MCL.conf
echo "rpcbind=0.0.0.0:33825" >> /home/komodian/.komodo/MCL/MCL.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.komodo/MCL/MCL.conf

echo "" > /home/komodian/.komodo/MCL/debug.log
# cat /home/komodian/.komodo/MCL/MCL.conf