#!/bin/bash

script_path=$(dirname $(realpath $0))

# AYA
rm -f /home/$USER/.aryacoin/aryacoin-cli
sudo ln -sf ${script_path}/cli_wrappers/aryacoin-cli /usr/local/bin/aryacoin-cli

# CHIPS
rm -f /home/$USER/.chips/chips-cli
sudo ln -sf ${script_path}/cli_wrappers/chips-cli /usr/local/bin/chips-cli

# EMC2
rm -f /home/$USER/.einsteinium/einsteinium-cli
sudo ln -sf ${script_path}/cli_wrappers/einsteinium-cli /usr/local/bin/einsteinium-cli

# KMD (3P)
rm -f /home/${USER}/.komodo_3p/komodo_3p-cli
rm -f /home/${USER}/.komodo_3p/komodo-cli
rm -f /home/${USER}/.komodo_3p/*-cli
rm -f /home/${USER}/.komodo/*-cli
sudo ln -sf ${script_path}/cli_wrappers/komodo_3p-cli /usr/local/bin/komodo_3p-cli

# MCL
rm -f /home/${USER}/.komodo_3p/MCL/mcl-cli
sudo ln -sf ${script_path}/cli_wrappers/mcl-cli /usr/local/bin/mcl-cli

# MIL
rm -f /home/$USER/.mil/mil-cli
sudo ln -sf ${script_path}/cli_wrappers/mil-cli /usr/local/bin/mil-cli

# TOKEL
rm -f /home/$USER/.komodo_3p/TOKEL/tokel-cli-bin
rm -f /home/$USER/.komodo_3p/TOKEL/tokel-cli
sudo ln -sf ${script_path}/cli_wrappers/tokel-cli /usr/local/bin/tokel-cli

# VRSC
rm -f /home/$USER/.komodo_3p/VRSC/verus-cli-bin
rm -f /home/$USER/.komodo_3p/VRSC/verus-cli
sudo ln -sf ${script_path}/cli_wrappers/verus-cli /usr/local/bin/verus-cli
