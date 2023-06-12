# notary_docker_3p

## Requirements

 - Docker
 - Docker Compose

## Setup

1. Clone this repository
2. Create a `.env` file in the root of the project with the following content:
```
RPC_USER=yourRPCus3rn@me
RPC_PASS=yourRPCp@ssw0rd
PUBKEY=YOUR_3P_NOTARY_PUBKEY
```
3. Run `docker-compose build` to build the deamons within the docker containers
4. Run `docker-compose up -d` to start the containers in the background
5. Use `docker-compose run <service> bash` to access an interactive shell (where <service> is the coin ticker in lowercase)

 To clear old docker cache `docker system prune -a --volumes` (this will mean everything must be rebuilt)

## Make Docker respect UFW

See this article for more info: https://www.techrepublic.com/article/how-to-fix-the-docker-and-ufw-security-flaw/

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

