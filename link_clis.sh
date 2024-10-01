#!/bin/bash

script_path=$(dirname $(realpath $0))

# AYA
rm -f ~/.aryacoin/aryacoin-cli
ln -sf ${script_path}/cli_wrappers/aryacoin-cli ~/.local/bin/aryacoin-cli
ln -sf ${script_path}/cli_wrappers/aryacoin-cli ~/.local/bin/aya-cli

# CHIPS
rm -f ~/.chips/chips-cli
ln -sf ${script_path}/cli_wrappers/chips-cli ~/.local/bin/chips-cli

# EMC2
rm -f ~/.einsteinium/einsteinium-cli
ln -sf ${script_path}/cli_wrappers/emc-cli ~/.local/bin/emc-cli
ln -sf ${script_path}/cli_wrappers/emc-cli ~/.local/bin/einsteinium-cli

# KMD (3P)
rm -f ~/.komodo_3p/komodo_3p-cli
rm -f ~/.komodo_3p/komodo-cli
rm -f ~/.komodo_3p/*-cli
rm -f ~/.komodo/*-cli
ln -sf ${script_path}/cli_wrappers/komodo_3p-cli ~/.local/bin/komodo_3p-cli
ln -sf ${script_path}/cli_wrappers/komodo_3p-cli ~/.local/bin/kmd_3p-cli

# MCL
rm -f ~/.komodo_3p/MCL/mcl-cli
ln -sf ${script_path}/cli_wrappers/mcl-cli ~/.local/bin/mcl-cli

# MIL
rm -f ~/.mil/mil-cli
ln -sf ${script_path}/cli_wrappers/mil-cli ~/.local/bin/mil-cli

# TOKEL
rm -f ~/.komodo_3p/TOKEL/tokel-cli-bin
rm -f ~/.komodo_3p/TOKEL/tokel-cli
ln -sf ${script_path}/cli_wrappers/tokel-cli ~/.local/bin/tokel-cli
ln -sf ${script_path}/cli_wrappers/tokel-cli ~/.local/bin/tkl-cli
