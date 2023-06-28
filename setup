#!/bin/bash

mkdir -p /home/${USER}/.zcash-params
./fetch-params.sh

source pubkey_3p.txt
if test -z "$pubkey"
then
  read -p "Enter your pubkey: " pubkey
  # TODO: validate pubkey
  echo "pubkey=${pubkey}" > pubkey_3p.txt
fi

echo "Setting up .env file..."
USER_ID=$(id -u)
GROUP_ID=$(id -g)
echo "PUBKEY=${pubkey}" > .env
echo "USER_ID=${USER_ID}" >> .env
echo "GROUP_ID=${GROUP_ID}" >> .env

./update_3p.sh "$1" "$@"
