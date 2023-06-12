# notary_docker_3p

Simple setup for running 3P notary node daemons for dPoW.

## Requirements

 - Docker
 - Docker Compose

## Setup

1. Clone this repository
2. Run `./setup.sh` to create the `.env` and `docker-compose.yml` files
3. Run `docker-compose build` to build the deamons within the docker containers
4. Run `docker-compose up -d` to start the containers in the background

## Usage

 - Use `docker-compose logs -f` to monitor the logs of all the containers
 - Use `docker-compose logs -f <service>` to monitor the logs of a single container (where <service> is the coin ticker in lowercase)
 - Use `docker-compose build <service>` to rebuild a single container (where <service> is the coin ticker in lowercase)
 - Use `docker-compose up <service> -d` to start a single container in the background (where <service> is the coin ticker in lowercase)
 - Use `docker-compose run <service> bash` to access an interactive shell (where <service> is the coin ticker in lowercase)
 - To clear old docker cache `docker system prune -a --volumes`. This will mean everything must be rebuilt, but the data folders will remain intact.
 

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

## What might go wrong?

If you already have data in the daemon data folders (e.g. from a previous season) then you might encounter some issues like below.
```
mil_1    | : You need to rebuild the database using -reindex-chainstate to change addressindex.
mil_1    | Please restart with -reindex or -reindex-chainstate to recover.
```

To overcome this, you can either delete the data folders and restart the containers, or enter the container to launch the daemons with `reindex` manually.

```
# Enter the container
docker-compose run <service> bash

# Launch the daemon with reindex
mild -reindex

# Monitor the daemon logs
tail -f ~/.mil/debug.log

# Exit the container
exit
```

