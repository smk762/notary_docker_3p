#!/bin/bash
set -euxo pipefail

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

read -p "Enter your pubkey: " PUBKEY

len=$(( RANDOM % 34 + 44 ))
RPC_USER=$(generate_random_string $len)
len=$(( RANDOM % 34 + 44 ))
RPC_PASS=$(generate_random_string $len)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

echo "PUBKEY=${PUBKEY}" > .env
echo "RPC_USER=${RPC_USER}" >> .env
echo "RPC_PASS=${RPC_PASS}" >> .env
echo "USER_ID=${USER_ID}" >> .env
echo "GROUP_ID=${GROUP_ID}" >> .env

cp docker-compose.template docker-compose.yml
sed "s/USERNAME/${USER}/gi" -i "docker-compose.yml"

mkdir -p /home/${USER}/.komodo_3p
mkdir -p /home/${USER}/.komodo_3p/VRSC
mkdir -p /home/${USER}/.komodo_3p/MCL
mkdir -p /home/${USER}/.komodo_3p/TOKEL