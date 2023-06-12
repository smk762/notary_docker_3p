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

 - Run `docker-compose up -d`
 - Run `docker-compose exec notary bash`