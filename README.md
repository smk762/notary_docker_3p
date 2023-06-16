# notary_docker_3p

Simple setup for running 3P notary node daemons for dPoW.
---
## Requirements

 - [Docker](https://docs.docker.com/engine/install/ubuntu/) / [w/ convenience script](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
 - [Docker Compose](https://docs.docker.com/compose/install/linux/#install-using-the-repository)
 - Docker linux post install steps: https://docs.docker.com/engine/install/linux-postinstall/ , Configure Docker to start on boot with systemd
 - 100GB+ disk space free
---
## Make Docker respect UFW

**Docker adds iptables rules that will override UFW rules!** 
Make sure to run the steps below to secure the ports used by Docker. See this article for more info: https://www.techrepublic.com/article/how-to-fix-the-docker-and-ufw-security-flaw/

Open docker config file
```
sudo nano /etc/default/docker
```

Add this line; save and exit.
```
DOCKER_OPTS="--iptables=false"
```

Restart docker
```
sudo systemctl restart docker
```
---
## Setup

1. Clone this repository: `git clone https://github.com/smk762/notary_docker_3p`
2. Run `./setup_3p.sh` to create the `.env` and `docker-compose.yml` files and build the daemon containers
3. Run `./start_3p.sh` to launch all the deamons within the docker containers, and tail their logs


As we will be running multiple instances of the KMD daemon on the server, we will be using a non-standard data folder and ports for the 3P KMD daemon. This is to avoid conflicts with the native KMD daemon running on the host machine for the "main" coins.
There are also some other minor differences with paths and ports used for 3P daemons within the docker containers, so a [modified `m_notary_3rdparty`](https://github.com/KomodoPlatform/dPoW/blob/season-seven/iguana/m_notary_3rdparty_docker) file is used to launch Iguana.

---
### Some other commands that may come in handy later:
- Run `./start_3p.sh <ticker>` to launch a specific deamon within a docker container, and tail it's logs
- Run `./iguana_3p.sh` to launch Iguana for the 3P daemons within the docker containers
- Run `./stop_3p.sh` to stop all the deamons
- Run `./stop_3p.sh <ticker>` to stop a specific deamon
When a new version of the daemon is announced:
- Run `./update_3p.sh` to stop all daemons, rebuild docker images, and then restart all daemons.
- Run `./update_3p.sh <ticker>` to stop a specific daemon, rebuild its docker image, and then restart the daemon.
- To clear old docker cache, use `docker system prune -a --volumes`. This will mean everything must be rebuilt, but the data folders will remain intact on the host machine.

---
### To use cli commands

Open wrapper script file for the deamon cli with `nano ~/komodo/src/komodo_3p-cli` and put the following inside:
```bash
#!/bin/bash
komodo-cli -conf=/home/${USER}/.komodo_3p/komodo.conf $@
```
Make the wrapper scripts executable:
```bash
chmod +x /home/$USER/komodo/src/komodo_3p-cli
```
Now we can create a symbolic links for the 3P instance of Komodo:
```bash
sudo ln -s /home/$USER/komodo/src/komodo_3p-cli /usr/local/bin/komodo_3p-cli
```
After building the 3P docker images, the cli binaries for the other 3P coins will be located in their `conf` folders, so we can create symbolic links for them as well:
```bash
# AYA
sudo ln -s /home/$USER/.aryacoin/aryacoin-cli /usr/local/bin/aryacoin-cli

# CHIPS
sudo ln -s /home/$USER/.chips/chips-cli /usr/local/bin/chips-cli

# EMC2
sudo ln -s /home/$USER/.einsteinium/einsteinium-cli /usr/local/bin/einsteinium-cli

# MCL
# For MCL, use `komodo-cli -ac_name=MCL`, or create a wrapper script and symlink it

# MIL
sudo ln -s /home/$USER/.mil/mil-cli /usr/local/bin/mil-cli

# TOKEL
sudo ln -s /home/$USER/.komodo/TOKEL/tokel-cli /usr/local/bin/tokel-cli

# VRSC
sudo ln -s /home/$USER/.komodo/VRSC/verus /usr/local/bin/verus-cli
```
---
### Updating daemon versions

When a repo hash or branch changes for an update, update the `COMMIT_HASH` arg in the `docker-compose.yml` file for the relevant service. Then run `docker compose build <service> --no-cache` to rebuild the container.

---
## What might go wrong?

#### Chain needs reindex

If you already have data in the daemon data folders (e.g. from a previous season) then you might encounter some issues like below.
```
mil_1    | : You need to rebuild the database using -reindex-chainstate to change addressindex.
mil_1    | Please restart with -reindex or -reindex-chainstate to recover.
```

To overcome this, you can either delete the data folders and restart the containers, or enter the container to launch the daemons with `reindex` manually.

```
# Enter the container
docker compose run <service> bash

# Launch the daemon with reindex
mild -reindex

# Monitor the daemon logs
tail -f ~/.mil/debug.log (you can also do this from outside the container, as the `.mil` folder is a shared volume)

# Exit the container
exit
```
#### Bind address already in use

If you see the following:
```
Error response from daemon: driver failed programming external connectivity on endpoint notary_docker_3p-kmd-1 (b38e98fe0534cf22b41c424be924de0b826835080e21cdf1b557c927295f2304): Error starting userland proxy: listen tcp4 0.0.0.0:7771: bind: address already in use
```

Make sure you are not running any other instances of the daemon on your host machine. Stop the deamons, and then run `docker compose up -d` again.
