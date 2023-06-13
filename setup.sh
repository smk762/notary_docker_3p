#!/bin/bash

read -p "Enter your pubkey: " PUBKEY

len=$(cat /dev/urandom | tr -dc '4-7' | fold -w 256 | head -n 1 | sed -e 's/^0*//' | head --bytes 2)
RPC_USER=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $len | head -n 1)
len=$(cat /dev/urandom | tr -dc '4-7' | fold -w 256 | head -n 1 | sed -e 's/^0*//' | head --bytes 2)
RPC_PASS=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $len | head -n 1)
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