#!/bin/bash

script_path=$(dirname $(realpath $0))
mkdir -p /home/$USER/.local/bin

# KMD (3P)
rm -f /home/${USER}/.komodo_3p/komodo_3p-cli
rm -f /home/${USER}/.komodo_3p/komodo-cli
rm -f /home/${USER}/.komodo_3p/*-cli
rm -f /home/${USER}/.komodo/*-cli
ln -sf ${script_path}/cli_wrappers/komodo_3p-cli /home/$USER/.local/bin/komodo_3p-cli
ln -sf ${script_path}/cli_wrappers/komodo_3p-cli /home/$USER/.local/bin/kmd_3p-cli

# MCL
rm -f /home/${USER}/.komodo_3p/MCL/mcl-cli
ln -sf ${script_path}/cli_wrappers/mcl-cli /home/$USER/.local/bin/mcl-cli

# TOKEL
rm -f /home/$USER/.komodo_3p/TOKEL/tokel-cli-bin
rm -f /home/$USER/.komodo_3p/TOKEL/tokel-cli
ln -sf ${script_path}/cli_wrappers/tokel-cli /home/$USER/.local/bin/tokel-cli
ln -sf ${script_path}/cli_wrappers/tokel-cli /home/$USER/.local/bin/tkl-cli
