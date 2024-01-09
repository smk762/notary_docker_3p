#!/bin/bash

# Place this script in /etc/letsencrypt/renewal-hooks/post/ to run when certs are renewed
# It will automatically update the cert in your mm2 docker container.
# Dont forget to update the user and domain variables!

user="USER"
domain="DOMAIN"

sudo chown -R $user:$user /etc/letsencrypt/archive/$domain/
sudo /usr/bin/setfacl -m "u:${user}:rx" /etc/letsencrypt/archive /etc/letsencrypt/live
sudo cp /etc/letsencrypt/live/$domain/privkey.pem /home/$user/notary_docker_3p/mm2/$domain/privkey.pem
sudo cp /etc/letsencrypt/live/$domain/fullchain.pem /home/$user/notary_docker_3p/mm2/$domain/fullchain.pem
cd /home/$user/notary_docker_3p/
/usr/bin/docker compose stop mm2 && /usr/bin/docker compose build mm2
/usr/bin/docker compose up mm2 -d
