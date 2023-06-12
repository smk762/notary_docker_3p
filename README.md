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
5. Use `docker-compose run <service> bash` to access an interactive shell (where <service> is the coin ticker in lowercase)

 To clear old docker cache `docker system prune -a --volumes` (this will mean everything must be rebuilt)

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

