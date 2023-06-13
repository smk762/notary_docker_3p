
mkdir -p /home/komodian/.mil
echo "server=1" > /home/komodian/.mil/mil.conf
echo "listen=1" >> /home/komodian/.mil/mil.conf
echo "daemon=1" >> /home/komodian/.mil/mil.conf
echo "txindex=1" >> /home/komodian/.mil/mil.conf
echo "spentindex=1" >> /home/komodian/.mil/mil.conf
echo "addressindex=1" >> /home/komodian/.mil/mil.conf
echo "port=41888" >> /home/komodian/.mil/mil.conf
echo "rpcport=41889" >> /home/komodian/.mil/mil.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.mil/mil.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.mil/mil.conf
echo "rpcbind=0.0.0.0:41889" >> /home/komodian/.mil/mil.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.mil/mil.conf

echo "" > /home/komodian/.mil/debug.log

# cat /home/komodian/.mil/mil.conf