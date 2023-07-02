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
2. Run `./setup` to create the `.env` and `docker-compose.yml` files and build the daemon containers
3. Run `./start` to launch all the deamons within the docker containers, and tail their logs
4. Run `./iguana_3p` to launch Iguana for the 3P daemons within the docker containers
5. Run `./stop` to stop all the deamons

As we will be running multiple instances of the KMD daemon on the server, we will be using a non-standard data folder and ports for the 3P KMD daemon. This is to avoid conflicts with the native KMD daemon running on the host machine for the "main" coins.
There are also some other minor differences with paths and ports used for 3P daemons within the docker containers, so a [modified `m_notary_3rdparty`](https://github.com/KomodoPlatform/dPoW/blob/season-seven/iguana/m_notary_3rdparty_docker) file is used to launch Iguana.

---
### Some other commands that may come in handy later:
- Run `./add_peers` to help add connections when doing initial sync.
- Run `./start <ticker>` to launch a specific deamon within a docker container, and tail it's logs
- Run `./stop <ticker>` to stop a specific deamon
- Run `./logs <ticker>` to view logs of a specific deamon
- Run `./purge` to remove all docker containers, images, volumes and networks. **Local chain data will be preserved.**
    - To clear space from older builds, run `./purge` while your containers are running. It will delete all other containers.
    - If all else fails and you want to start fresh, run `./stop` first, then `./purge` to delete everything.

---
### Updating daemon versions

When there is an update to any daemon repository, we need to update our `docker-compose.yml` file with the updated `COMMIT_HASH` for deamons which need to be rebuilt.
- Run `./update` to stop all daemons, update this repo, regenerate the `docker-compose.yml` file, and rebuild the docker images.
- Run `./update <ticker>` to stop a specific daemon and rebuild its image.
- Run `./update <ticker> --no-cache` to stop a specific daemon and force rebuild its image from fresh.
- Once update is complete, run `./start` to start all daemons again.
- Run `./setup nobuild` to refresh configs without rebuilding images. 

---
### To use cli commands
Wrapper scripts for all CLI commands are automatically created and linked to `/usr/local/bin` when the docker containers are built. This allows you to run commands like `mcl-cli getinfo` from anywhere on the host machine.

---
## What might go wrong?

#### Chain needs reindex

If you already have data in the daemon data folders (e.g. from a previous season) then you might encounter some issues like below.
```
mil_1    | : You need to rebuild the database using -reindex-chainstate to change addressindex.
mil_1    | Please restart with -reindex or -reindex-chainstate to recover.
```

To overcome this, you can either:
- Delete the data folders and restart the containers
- Stop the service with `./stop <ticker>` and then run `./start <ticker> -reindex` to launch the daemon with reindex.
- Enter the container with to launch the daemons with `-reindex` manually (see below)

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

#### More info

https://www.cloudbees.com/blog/how-to-clean-up-deleting-all-docker-images
