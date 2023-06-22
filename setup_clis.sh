#!/bin/bash

# KMD (3P)
echo "#!/bin/bash" >  /home/${USER}/.komodo_3p/komodo_3p-cli
echo 'komodo-cli -conf=/home/'${USER}'/.komodo_3p/komodo.conf $@' >> /home/${USER}/.komodo_3p/komodo_3p-cli
chmod +x /home/${USER}/.komodo_3p/komodo_3p-cli
sudo ln -s /home/${USER}/.komodo_3p/komodo_3p-cli /usr/local/bin/komodo_3p-cli

# MCL
echo "#!/bin/bash" >  /home/${USER}/.komodo_3p/MCL/mcl-cli
echo 'komodo-cli -conf=/home/'${USER}'/.komodo_3p/MCL/MCL.conf $@' >> /home/${USER}/.komodo_3p/MCL/mcl-cli
chmod +x /home/${USER}/.komodo_3p/MCL/mcl-cli
sudo ln -s /home/${USER}/.komodo_3p/MCL/mcl-cli /usr/local/bin/mcl-cli

# AYA
sudo ln -s /home/$USER/.aryacoin/aryacoin-cli /usr/local/bin/aryacoin-cli

# CHIPS
sudo ln -s /home/$USER/.chips/chips-cli /usr/local/bin/chips-cli

# EMC2
sudo ln -s /home/$USER/.einsteinium/einsteinium-cli /usr/local/bin/einsteinium-cli

# MIL
sudo ln -s /home/$USER/.mil/mil-cli /usr/local/bin/mil-cli

# TOKEL
echo "#!/bin/bash" >  /home/${USER}/.komodo_3p/TOKEL/tokel-cli
echo 'tokel-cli-bin -conf=/home/'${USER}'/.komodo_3p/TOKEL/TOKEL.conf $@' >> /home/${USER}/.komodo_3p/TOKEL/tokel-cli
chmod +x /home/${USER}/.komodo_3p/TOKEL/tokel-cli
sudo ln -s /home/$USER/.komodo_3p/TOKEL/tokel-cli-bin /usr/local/bin/tokel-cli-bin
sudo ln -s /home/$USER/.komodo_3p/TOKEL/tokel-cli /usr/local/bin/tokel-cli

# VRSC
echo "#!/bin/bash" >  /home/${USER}/.komodo_3p/VRSC/verus-cli
echo 'verus-cli-bin -conf=/home/'${USER}'/.komodo_3p/VRSC/VRSC.conf $@' >> /home/${USER}/.komodo_3p/VRSC/verus-cli
chmod +x /home/${USER}/.komodo_3p/VRSC/verus-cli
sudo ln -s /home/$USER/.komodo_3p/VRSC/verus-cli-bin /usr/local/bin/verus-cli-bin
sudo ln -s /home/$USER/.komodo_3p/VRSC/verus-cli /usr/local/bin/verus-cli
