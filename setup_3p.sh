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

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

echo "Setting up .env file..."
echo "PUBKEY=${pubkey}" > .env
echo "RPC_USER=${RPC_USER}" >> .env
echo "RPC_PASS=${RPC_PASS}" >> .env
echo "USER_ID=${USER_ID}" >> .env
echo "GROUP_ID=${GROUP_ID}" >> .env

echo "Updating docker-compose.yml..."
cp docker-compose.template docker-compose.yml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"

mkdir -p /home/${USER}/.komodo_3p
mkdir -p /home/${USER}/.komodo_3p/VRSC
mkdir -p /home/${USER}/.komodo_3p/MCL
mkdir -p /home/${USER}/.komodo_3p/TOKEL

echo "Building docker images..."
docker compose build
