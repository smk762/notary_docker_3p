#!/bin/bash

script_path=$(dirname $(realpath $0))

# AYA
rm -f /home/$USER/.aryacoin/aryacoin-cli
ln -sf ${script_path}/cli_wrappers/aryacoin-cli /home/$USER/.local/bin/aryacoin-cli
ln -sf ${script_path}/cli_wrappers/aryacoin-cli /home/$USER/.local/bin/aya-cli

# CHIPS
rm -f /home/$USER/.chips/chips-cli
ln -sf ${script_path}/cli_wrappers/chips-cli /home/$USER/.local/bin/chips-cli

# EMC2
rm -f /home/$USER/.einsteinium/einsteinium-cli
ln -sf ${script_path}/cli_wrappers/emc-cli /home/$USER/.local/bin/emc-cli
ln -sf ${script_path}/cli_wrappers/emc-cli /home/$USER/.local/bin/einsteinium-cli

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

# MIL
rm -f /home/$USER/.mil/mil-cli
ln -sf ${script_path}/cli_wrappers/mil-cli /home/$USER/.local/bin/mil-cli

# TOKEL
rm -f /home/$USER/.komodo_3p/TOKEL/tokel-cli-bin
rm -f /home/$USER/.komodo_3p/TOKEL/tokel-cli
ln -sf ${script_path}/cli_wrappers/tokel-cli /home/$USER/.local/bin/tokel-cli
ln -sf ${script_path}/cli_wrappers/tokel-cli /home/$USER/.local/bin/tkl-cli
