#!/usr/bin/env python3
import os
import sys
import json
import getpass
import string
import shutil
import secrets
import os.path
import requests
import mnemonic
from const import home, script_path, dpow_path, coins, coins_main, coins_3p
from dotenv import load_dotenv

load_dotenv()
MM2_RPC_IP = os.getenv('MM2_RPC_IP')
DOMAIN = os.getenv('DOMAIN')


def format_param(param, value):
    return f'-{param}={value}'


def generate_rpc_pass(length=24):
    special_chars = "@~-_|():+"
    rpc_chars = string.ascii_letters + string.digits + special_chars
    return "".join(secrets.choice(rpc_chars) for _ in range(length))


def get_pubkey_address(coin: str, pubkey: str) -> str:
    url = "https://stats.kmd.io/api/tools/address_from_pubkey/"
    url += f"?pubkey={pubkey}"
    try:
        data = requests.get(url).json()["results"]
        if "error" in data:
            print(f"Error: {data['error']}")
            return ""
        for i in data:
            if i["coin"] == coin:
                return i["address"]
    except Exception as e:
        print(f"Error: {e}")
    return ""


def get_coin_server(coin: str) -> str:
    if coin in coins_main:
        return "main"
    elif coin in coins_3p:
        return "3p"
    return f"no server for {coin}!"


def get_coin_daemon(coin):
    if coin in coins_main:
        return coins_main[coin]["daemon"]
    elif coin in coins_3p:
        return coins_3p[coin]["daemon"]
    return f"no daemon for {coin}"


def get_data_path(coin, container=True):
    return os.path.split(get_conf_file(coin, container))[0]


def get_debug_file(coin, container=True) -> str:
    path = get_data_path(coin, container)
    if container:
        path = path.replace(home, "/home/komodian")
    return f"{path}/debug.log"


def get_conf_file(coin, container=True):
    if container:
        data_dir = ".komodo"
    else:
        data_dir = ".komodo_3p"
    if coin == 'AYA':
        conf_file = f"{home}/.aryacoin/aryacoin.conf"
    elif coin == 'CHIPS':
        conf_file = f"{home}/.chips/chips.conf"
    elif coin == 'EMC2':
        conf_file = f"{home}/.einsteinium/einsteinium.conf"
    elif coin == 'KMD':
        conf_file = f"{home}/.komodo/komodo.conf"
    elif coin == 'LTC':
        conf_file = f"{home}/.litecoin/litecoin.conf"
    elif coin == 'MIL':
        conf_file = f"{home}/.mil/mil.conf"
    elif coin == 'KMD_3P':
        conf_file = f"{home}/{data_dir}/komodo.conf"
    elif coin == 'MCL':
        conf_file = f"{home}/{data_dir}/MCL/MCL.conf"
    elif coin == 'TOKEL':
        conf_file = f"{home}/{data_dir}/TOKEL/TOKEL.conf"
    else:
        conf_file = f"{home}/.komodo/{coin}/{coin}.conf"
    return conf_file


def get_cli_command(coin, container=True) -> str:
    if coin == 'AYA':
        return f"aryacoin-cli"
    if coin == 'CHIPS':
        return f"chips-cli"
    if coin == 'EMC2':
        if not container:
            return f"emc-cli"
        else:
            return f"einsteinium-cli"
    if coin == 'KMD':
        return f"komodo-cli"
    if coin == 'KMD_3P':
        if not container:
            return f"komodo_3p-cli"
        else:
            return f"komodo-cli"
    if coin == 'LTC':
        return f"litecoin-cli"
    if coin == 'MCL':
        if not container:
            return f"mcl-cli"
        else:
            return f"mcl-cli -ac_name=MCL"
    if coin == 'MIL':
        return f"mil-cli"
    if coin == 'TOKEL':
        return f"tokel-cli"
    return f"komodo-cli -ac_name={coin}"
  

def get_launch_params(coin):
    launch = get_coin_daemon(coin)
    if coin == 'KMD':
        launch += " -gen -genproclimit=1 -minrelaytxfee=0.000035 -opretmintxfee=0.004 -notary=.litecoin/litecoin.conf"
    elif coin == 'KMD_3P':
        launch += " -minrelaytxfee=0.000035 -opretmintxfee=0.004 -notary"
    elif coin == 'MCL':
        launch += " -ac_name=MCL -ac_supply=2000000 -ac_cc=2 -addnode=5.189.149.242 -addnode=161.97.146.150 -addnode=149.202.158.145 -addressindex=1 -spentindex=1 -ac_marmara=1 -ac_staked=75 -ac_reward=3000000000 -daemon"

    # Not required for 3P coins
    # for i in assetchains:
    #    if i["ac_name"] == coin:
    #        params = []
    #        for param, value in i.items():
    #            if isinstance(value, list):
    #                for dupe_value in value:
    #                    params.append(format_param(param, dupe_value))
    #            else:
    #                params.append(format_param(param, value))
    #        launch_str = ' '.join(params)
    #        launch += f" {launch_str}"
    server = get_coin_server(coin)
    pubkey = get_user_pubkey(server)
    launch += f" -pubkey={pubkey}"
    return launch


def get_domain():
    if DOMAIN:
        if DOMAIN != "":
            return DOMAIN
    if os.path.exists(f"{script_path}/mm2/MM2.json"):
        with open(f"{script_path}/mm2/MM2.json", "r") as f:
            return json.load(f)["wss_certs"]["certificate"].split("/")[-2]
    return input("Enter your domain name: ")


def get_user_pubkey(server='3p'):
    if server == '3p':
        file = f"{dpow_path}/iguana/pubkey_3p.txt"
    else:
        file = f"{dpow_path}/iguana/pubkey.txt"
    if not os.path.exists(file):
        print(f"{file} does not exist!")
        print(f"Please install dPoW, and make sure to create your pubkey.txt and pubkey_3p.txt files in {dpow_path}/iguana!")
        sys.exit()
    if os.path.exists(file):
        with open(file, 'r') as f:
            for line in f:
                if line.startswith("pubkey="):
                    return line.split("=")[1].strip()
    print(f"No {file} found! Lets create it now...")
    pubkey = input(f"Enter your {server} pubkey: ")
    with open(file, 'w') as f:
        f.write(f"pubkey={pubkey}")
    return pubkey


def create_cli_wrappers():
    for coin in coins:
        cli = get_cli_command(coin, False)
        if "ac_name" in cli:
            wrapper = f"cli_wrappers/{coin.lower()}-cli"
        else:
            wrapper = f"cli_wrappers/{cli}"
        with open(wrapper, 'w') as conf:
            conf.write('#!/bin/bash\n')
            conf.write(f'docker exec {coin.lower()} {get_cli_command(coin, True)} "$@"\n')
            os.chmod(wrapper, 0o755)


def create_launch_files():
    for coin in coins:
        launch = get_launch_params(coin)
        launch_file = f"docker_files/launch_files/run_{coin}.sh"
        # This is messy, but it works. Will make it cleaner later
        # inside container, komodo-cli is just komodo-cli
        coin = coin.split('_')[0]
        debug = get_debug_file(coin)
        cli = get_cli_command(coin)
        with open(launch_file, 'w') as f:
            with open('templates/launch.template', 'r') as t:
                for line in t.readlines():
                    line = line.replace('CLI', cli)
                    line = line.replace('COIN', coin)
                    line = line.replace('DEBUG', debug)
                    line = line.replace('LAUNCH', launch)
                    f.write(line)
            os.chmod(launch_file, 0o755)


def create_confs(server="3p", coins_list=None):
    if server == "3p":
        data = coins_3p
        rpcip = "0.0.0.0"
    else:
        data = coins_main
        rpcip = "127.0.0.1"
    if coins_list:
        coins = coins_list
    else:
        coins = list(data.keys())
    for coin in coins:
        rpcuser = generate_rpc_pass()
        rpcpass = generate_rpc_pass()
        conf_file = get_conf_file(coin, False)
        data_path = get_data_path(coin, False)
        if not os.path.exists(data_path):
            os.makedirs(data_path)
        # Use existing rpcuser and rpcpass if they exist
        if os.path.exists(conf_file):
            with open(conf_file, 'r') as f:
                lines = f.readlines()
                for line in lines:
                    if line.startswith('rpcuser'):
                        rpcuser = line.split('=')[1].strip()
                    if line.startswith('rpcpassword'):
                        rpcpass = line.split('=')[1].strip()
            
        with open(conf_file, 'w') as conf:
            conf.write(f'rpcuser={rpcuser}\n')
            conf.write(f'rpcpassword={rpcpass}\n')
            conf.write('txindex=1\n')
            # These will force a reindex on a bootstrap
            #conf.write('addressindex=1\n')
            #conf.write('spentindex=1\n')
            conf.write('server=1\n')
            conf.write('daemon=1\n')
            conf.write('rpcworkqueue=256\n')
            conf.write(f'rpcbind={rpcip}:{data[coin]["rpcport"]}\n')
            conf.write(f'rpcallowip={rpcip}/0\n')
            conf.write(f'port={data[coin]["p2pport"]}\n')
            conf.write(f'rpcport={data[coin]["rpcport"]}\n')
            conf.write('addnode=77.75.121.138 # Dragonhound_AR\n')
            conf.write('addnode=209.222.101.247 # Dragonhound_NA\n')
            conf.write('addnode=103.195.100.32 # Dragonhound_DEV\n')
            conf.write('addnode=178.159.2.9 # Dragonhound_EU\n')
            conf.write('addnode=148.113.1.52 # gcharang_AR\n')
            conf.write('addnode=51.161.209.100 # gcharang_SH\n')
            conf.write('addnode=148.113.8.6 # gcharang_DEV\n')
            conf.write('addnode=144.76.80.75 # Alright_DEV\n')
            conf.write('addnode=65.21.77.109 # Alright_EU\n')
            conf.write('addnode=89.19.26.211 # Marmara1\n')
            conf.write('addnode=89.19.26.212 # Marmara2\n')
            if coin in ["MCL", "TOKEL", "KMD_3P"] or (coin in coins_main and coin != "LTC"):
                conf.write('whitelistaddress=RDragoNHdwovvsDLSLMiAEzEArAD3kq6FN # s6_dragonhound_DEV_main\n')
                conf.write('whitelistaddress=RLdmqsXEor84FC8wqDAZbkmJLpgf2nUSkq # s6_dragonhound_DEV_3p\n')
                conf.write('whitelistaddress=RHi882Amab35uXjqBZjVxgEgmkkMu454KK # s7_dragonhound_DEV_main\n')
                conf.write('whitelistaddress=RHound8PpyhVLfi56dC7MK3ZvvkAmB3bvQ # s7_dragonhound_DEV_3p\n')
                conf.write('whitelistaddress=RSzqu1ZmAbbM2WUNdqNtPLTcLB54kwLp6D # Notary Faucet\n')                
                # Adds user main & 3p addresses for this node to whitelist
                for server in ["3p", "main"]:
                    address = get_pubkey_address("KMD", get_user_pubkey(server))
                    if address != "":
                        conf.write(f'whitelistaddress={address} # User {server} KMD address\n')
                print(f"PLEASE MANUALLY ADD ANY ADDITIONAL WHITELIST ADDRESSES TO {conf_file}!")
        # create debug.log files if not existing
        debug_file = get_debug_file(coin, False)
        if not os.path.exists(debug_file):
            with open(debug_file, 'w') as f:
                f.write('')


def create_compose_yaml(server='3p'):
    if server == '3p':
        shutil.copy('templates/docker-compose.template_3p', 'docker-compose.yml')
    else:
        # Not yet used in 3P repo
        shutil.copy('templates/docker-compose.template_main', 'docker-compose.yml')
        with open('docker-compose.yml', 'a+') as conf:
            for coin in coins_main:
                if coin == 'KMD':
                    cli = "komodo-cli"
                else:
                    cli = f"komodo-cli -ac_name={coin}"
                p2pport = coins_main[coin]["p2pport"]
                rpcport = coins_main[coin]["rpcport"]
                conf.write(f'  {coin.lower()}:\n')
                conf.write('    env_file:\n')
                conf.write('      - .env\n')
                conf.write('    build:\n')
                conf.write('      context: ./docker_files\n')
                conf.write('      dockerfile: Dockerfile.KMD\n')
                conf.write('      args:\n')
                conf.write('        - USER_ID=$USER_ID\n')
                conf.write('        - GROUP_ID=$GROUP_ID\n')
                conf.write('        - COMMIT_HASH=0adeeab\n')
                conf.write(f'        - SERVICE_CLI="{cli}"\n')
                conf.write('    ports:\n')
                conf.write(f'      - "127.0.0.1:{p2pport}:{p2pport}"\n')
                conf.write(f'      - "127.0.0.1:{rpcport}:{rpcport}"\n')
                conf.write('    volumes:\n')
                conf.write('      - <<: *zcash-params\n')      
                if coin == "KMD":
                    conf.write('      - /home/USERNAME/.komodo:/home/komodian/.komodo\n')
                else:
                    conf.write(f'      - /home/USERNAME/.komodo/{coin}:/home/komodian/.komodo/{coin}\n')
                conf.write(f"    container_name: {coin.lower()}\n")
                conf.write("    shm_size: '2gb'\n")
                conf.write('    restart: always\n')
                conf.write('    stop_grace_period: 10s\n')
                conf.write('    logging:\n')
                conf.write('      driver: "json-file"\n')
                conf.write('      options:\n')
                conf.write('        max-size: "20m"\n')
                conf.write('        max-file: "10"\n')
                conf.write(f'    command: ["/run_{coin}.sh"]\n')
                conf.write('\n')


def get_mm2_domain():
    if os.path.exists(f"{script_path}/mm2/MM2.json"):
        with open(f"{script_path}/mm2/MM2.json", "r") as f:
            certpath = json.load(f)["wss_certs"]["certificate"]
            domain = certpath.split('/')[-2]
            return domain
    return ""


def get_mm2_userpass():
    if os.path.exists(f"{script_path}/mm2/MM2.json"):
        with open(f"{script_path}/mm2/MM2.json", "r") as f:
            return json.load(f)["rpc_password"]
    return generate_rpc_pass(16)

def update_mm2():
    with open(f"{script_path}/mm2/MM2.json", "r") as f:
        config = json.load(f)
        config.update({
            "netid": 8762,
            "seednodes": ["icefyre.dragon-seed.com", "kalessin.dragon-seed.com", "smaug.dragon-seed.com"],
        })
    with open(f"{script_path}/mm2/MM2.json", "w+") as f:
        json.dump(config, f, indent=4)


def setup_mm2(domain):
    rpc_password = get_mm2_userpass()
    if not os.path.exists(f"{script_path}/mm2/MM2.json"):
        print(f"{script_path}/mm2/MM2.json does not exist! Lets create one.")
        m = mnemonic.Mnemonic('english')
        mm2_seed = m.generate(strength=256)

        conf = {
            "gui": "S7_Notary",
            "netid": 8762,
            "i_am_seed": True,
            "rpc_local_only": False,
            "rpcport": 7783,
            "rpcip": "0.0.0.0",
            "rpc_password": rpc_password,
            "passphrase": mm2_seed,
            "seednodes": ["icefyre.dragon-seed.com", "kalessin.dragon-seed.com", "smaug.dragon-seed.com"],
            "metrics": 120,
            "wss_certs": {
                "server_priv_key": f"/home/komodian/mm2/{domain}/privkey.pem",
                "certificate": f"/home/komodian/mm2/{domain}/fullchain.pem"
            }
        }
        with open(f"{script_path}/mm2/MM2.json", "w+") as f:
            json.dump(conf, f, indent=4)
        print("MM2.json file created.")

    with open(f"{script_path}/mm2/rpc", "w+") as f:
        f.write(f'rpc_password="{rpc_password}"\n')
    print("rpc file created.")

    
    user = getpass.getuser()
    hook_script = f"{script_path}/mm2/post-cert-renew.sh"
    user_hook_script = f"{script_path}/mm2/post-cert-renew-{user}.sh"
    print(f"Updating post renew hook: {hook_script} for {user}@{domain}")
    with open(hook_script, "r") as f:
        lines = f.readlines()
        new_lines = []
        for line in lines:
            line = line.replace("USER", user)
            line = line.replace("DOMAIN", domain)
            new_lines.append(line)
    with open(f"{user_hook_script}", 'w') as f:
        for line in new_lines:
            f.write(line)


# Tests to confirm pubeys set
get_user_pubkey('main')
get_user_pubkey('3p')



if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('No arguments given, exiting.')
    elif sys.argv[1] == 'clis':
        create_cli_wrappers()
    elif sys.argv[1] == 'confs':
        # Temporary to fix earlier misconfiguration
        create_confs()
    elif sys.argv[1] == 'launch':
        create_launch_files()
    elif sys.argv[1] == 'yaml':
        create_compose_yaml()
    elif sys.argv[1] == 'update_mm2':
        update_mm2()
    elif sys.argv[1] == 'get_domain':
        print(get_domain())
    elif sys.argv[1] == 'setup_mm2':
        if len(sys.argv) < 3:
            domain = get_domain()
        else:
            domain = sys.argv[2]
        setup_mm2(domain)
    elif sys.argv[1] == 'get_password':
        print(generate_rpc_pass())
    else:
        print('Invalid option, must be in ["clis", "confs", "launch", "yaml", "setup_mm2", "get_password"]')
