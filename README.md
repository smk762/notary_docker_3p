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
Wrapper scripts for all CLI commands are automatically created and linked to `/home/${USER}/.local/bin` when the docker containers are built. This allows you to run commands like `mcl-cli getinfo` from anywhere on the host machine.


### AtomicDEX Seed Node
The `mm2` container is used to run a seed node for AtomicDEX. It is not mandatory to run this container, but it is recommended.
The seed node will generate its own seed prase and rpcpassword on first run. If you want to use your own, edit `docker_files/mm2_files/MM2.json` and rebuild the mm2 container.

Before building and launching the AtomicDEX container, we need to setup SSL certificates for WSS capability. For this, we'll need to register a domain and generate SSL certificates (in the container). 

#### Step 1: Get a Domain Name
There are many providers, and they are available for as low as $5/year. I'll use https://www.hover.com/domain-pricing for example.

Setup nameservers for DNS propagation - https://help.hover.com/hc/en-us/articles/217282477
Setup DNS records to link IP address with domain - https://help.hover.com/hc/en-us/articles/217282457-Managing-DNS-records-

I'll be using my 3P nodes, though you can run the mm2 seednode on a different server in any region.
My domain name will be `smk.dog`. The settings below will create the subdomains `dev.smk.dog` and `na.smk.dog` pointing to my 3P Dev & NA servers.

![image](https://user-images.githubusercontent.com/35845239/171760406-3dfb473a-5db9-47eb-bdaf-3b4e81ae739c.png)

Additional subdomains for each of your nodes can be added as required.

![image](https://user-images.githubusercontent.com/35845239/171760521-1f0c3a59-3fbd-4c9e-8abf-6249bd856c57.png)


#### Step 2: Generate SSL certificates with [LetsEncrypt](https://letsencrypt.org/getting-started/)

- Run `./setup` to regenerate the `docker-compose.yml` file with a block for the `mm2` service
- Run `./setup_mm2` to generate an MM2.json file, get the latest coins file, get SSL certificates, and build the mm2 container.

#### Step 3: Launch the AtomicDEX container

- Run `./start mm2` to launch the mm2 container
- Try `cd mm2 && ./version` to confirm the host machine can recieve repsonses from AtomicDEX API commands.

#### Step 4: Confirm WSS is working

You can confirm external connections are being accepted by going to https://websocketking.com/ and trying to connect to your domain on port 38900. For example, `wss://dev.smk.dog:38900`

![image](https://user-images.githubusercontent.com/35845239/171772951-86d6fb8e-c9d0-40ee-88b6-3124a942d1b8.png)

#### Step 4: Register your SeedNode's PeerID

Shortly after launch `mm2`, you should see a line in the logs like below:
```
mm2_libp2p::atomicdex_behaviour:653] INFO Local peer id: PeerId("12D3KooWNGGBfPWQbubupECdkYhj1VomMLUUAYpsR2Bo3R4NzHju")
```
The simplest way to find this is via `docker compose logs mm2 | grep Local`

DM the `PeerID` value to @smk on Discord, and it will be added to the notary seednode list for uptime and version monitoring to apply the bonus scoring for participating notaries.

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
