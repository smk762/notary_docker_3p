
mkdir -p /home/komodian/.einsteinium
echo "server=1" > /home/komodian/.einsteinium/einsteinium.conf
echo "listen=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "daemon=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "txindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "spentindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "addressindex=1" >> /home/komodian/.einsteinium/einsteinium.conf
echo "port=41878" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcport=41879" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcuser=${RPC_USER}" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcpassword=${RPC_PASS}" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcbind=0.0.0.0:41879" >> /home/komodian/.einsteinium/einsteinium.conf
echo "rpcallowip=0.0.0.0/0" >> /home/komodian/.einsteinium/einsteinium.conf

echo "" > /home/komodian/.einsteinium/debug.log

echo "${COMMIT_HASH}" > /home/komodian/COMMIT_HASH

# cat /home/komodian/.einsteinium/einsteinium.conf
