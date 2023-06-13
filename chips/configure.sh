
mkdir -p /home/komodian/.chips
echo "server=1" > /home/komodian/.chips/chips.conf
echo "listen=1" >> /home/komodian/.chips/chips.conf
echo "daemon=1" >> /home/komodian/.chips/chips.conf
echo "txindex=1" >> /home/komodian/.chips/chips.conf
echo "spentindex=1" >> /home/komodian/.chips/chips.conf
echo "addressindex=1" >> /home/komodian/.chips/chips.conf
echo "port=57777" >> /home/komodian/.chips/chips.conf
echo "rpcport=57776" >> /home/komodian/.chips/chips.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.chips/chips.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.chips/chips.conf
echo "rpcbind=0.0.0.0:57776" >> /home/komodian/.chips/chips.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.chips/chips.conf

echo "" > /home/komodian/.chips/debug.log
# cat /home/komodian/.chips/chips.conf
