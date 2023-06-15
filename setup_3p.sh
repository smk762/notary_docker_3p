#!/bin/bash

generate_random_string() {
  local length=$1
  local output=""
  exec 10< /dev/urandom
  while (( ${#output} < length )); do
    read -n $length -u 10 str
    str=$(tr -dc 'a-zA-Z0-9' <<< "$str")
    output="$output$str"
  done
  output=${output:0:$length}
  echo "$output"
  exec 10<&-
}

source /home/${USER}/dPoW/iguana/pubkey_3p.txt
if test -z "$pubkey"
then
  read -p "Enter your pubkey: " pubkey
  # TODO: validate pubkey
  echo "pubkey=${pubkey}" > /home/${USER}/dPoW/iguana/pubkey_3p.txt
fi

echo "Setting up .env file..."
USER_ID=$(id -u)
GROUP_ID=$(id -g)
echo "PUBKEY=${pubkey}" > .env
echo "USER_ID=${USER_ID}" >> .env
echo "GROUP_ID=${GROUP_ID}" >> .env

echo "Updating docker-compose.yml..."
cp docker-compose.template docker-compose.yml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"

echo "Setting up conf files and data folders..."

mkdir -p /home/${USER}/cli-binaries

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.komodo_3p
echo "server=1" > /home/${USER}/.komodo_3p/komodo.conf
echo "listen=1" >> /home/${USER}/.komodo_3p/komodo.conf
echo "daemon=1" >> /home/${USER}/.komodo_3p/komodo.conf
echo "txindex=1" >> /home/${USER}/.komodo_3p/komodo.conf
echo "spentindex=1" >> /home/${USER}/.komodo_3p/komodo.conf
echo "addressindex=1" >> /home/${USER}/.komodo_3p/komodo.conf
echo "port=8770" >> /home/${USER}/.komodo_3p/komodo.conf
echo "rpcport=8771" >> /home/${USER}/.komodo_3p/komodo.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.komodo_3p/komodo.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.komodo_3p/komodo.conf
echo "rpcbind=0.0.0.0:8771" >> /home/${USER}/.komodo_3p/komodo.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.komodo_3p/komodo.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.komodo_3p/komodo.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.komodo_3p/komodo.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.komodo_3p/komodo.conf
echo "" > /home/${USER}/.komodo_3p/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.komodo_3p/TOKEL
echo "server=1" > /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "listen=1" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "daemon=1" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "txindex=1" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "spentindex=1" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "addressindex=1" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "port=29404" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "rpcport=29405" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "rpcbind=0.0.0.0:29405" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.komodo_3p/TOKEL/TOKEL.conf
echo "" > /home/${USER}/.komodo_3p/TOKEL/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.komodo_3p/MCL
echo "server=1" > /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "listen=1" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "daemon=1" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "txindex=1" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "spentindex=1" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "addressindex=1" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "port=33824" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "rpcport=33825" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "rpcbind=0.0.0.0:33825" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.komodo_3p/MCL/MCL.conf
echo "" > /home/${USER}/.komodo_3p/MCL/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.komodo_3p/VRSC
echo "server=1" > /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "listen=1" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "daemon=1" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "txindex=1" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "spentindex=1" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "addressindex=1" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "port=27485" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "rpcport=27486" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "rpcbind=0.0.0.0:27486" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.komodo_3p/VRSC/VRSC.conf
echo "" > /home/${USER}/.komodo_3p/VRSC/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.aryacoin
echo "server=1" > /home/${USER}/.aryacoin/aryacoin.conf
echo "listen=1" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "daemon=1" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "txindex=1" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "spentindex=1" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "addressindex=1" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "port=26001" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "rpcport=9432" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "rpcbind=0.0.0.0:9432" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.aryacoin/aryacoin.conf
echo "" > /home/${USER}/.aryacoin/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.chips
echo "server=1" > /home/${USER}/.chips/chips.conf
echo "listen=1" >> /home/${USER}/.chips/chips.conf
echo "daemon=1" >> /home/${USER}/.chips/chips.conf
echo "txindex=1" >> /home/${USER}/.chips/chips.conf
echo "spentindex=1" >> /home/${USER}/.chips/chips.conf
echo "addressindex=1" >> /home/${USER}/.chips/chips.conf
echo "port=57777" >> /home/${USER}/.chips/chips.conf
echo "rpcport=57776" >> /home/${USER}/.chips/chips.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.chips/chips.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.chips/chips.conf
echo "rpcbind=0.0.0.0:57776" >> /home/${USER}/.chips/chips.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.chips/chips.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.chips/chips.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.chips/chips.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.chips/chips.conf
echo "" > /home/${USER}/.chips/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.einsteinium
echo "server=1" > /home/${USER}/.einsteinium/einsteinium.conf
echo "listen=1" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "daemon=1" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "txindex=1" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "spentindex=1" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "addressindex=1" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "port=41878" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "rpcport=41879" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "rpcbind=0.0.0.0:41879" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.einsteinium/einsteinium.conf
echo "" > /home/${USER}/.einsteinium/debug.log

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)

mkdir -p /home/${USER}/.mil
echo "server=1" > /home/${USER}/.mil/mil.conf
echo "listen=1" >> /home/${USER}/.mil/mil.conf
echo "daemon=1" >> /home/${USER}/.mil/mil.conf
echo "txindex=1" >> /home/${USER}/.mil/mil.conf
echo "spentindex=1" >> /home/${USER}/.mil/mil.conf
echo "addressindex=1" >> /home/${USER}/.mil/mil.conf
echo "port=41888" >> /home/${USER}/.mil/mil.conf
echo "rpcport=41889" >> /home/${USER}/.mil/mil.conf
echo "rpcuser=${RPC_USER}" >> /home/${USER}/.mil/mil.conf
echo "rpcpassword=${RPC_PASS}" >> /home/${USER}/.mil/mil.conf
echo "rpcbind=0.0.0.0:41889" >> /home/${USER}/.mil/mil.conf
echo "rpcallowip=0.0.0.0/0" >> /home/${USER}/.mil/mil.conf
echo "addnode=15.235.204.174" >> /home/${USER}/.mil/mil.conf
echo "addnode=209.222.101.247" >> /home/${USER}/.mil/mil.conf
echo "addnode=103.195.100.32" >> /home/${USER}/.mil/mil.conf
echo "" > /home/${USER}/.mil/debug.log

echo "Building docker images..."
docker compose build
