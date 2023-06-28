#!/bin/python3
import string
import shutil
import secrets
import json
import sys
import os

# Get the list of coins

home = os.path.expanduser('~')

with open(f'assetchains.json') as file:
    assetchains = json.load(file)

coins_main = {
    "CCL": {
        "daemon": "komodod",
        "p2pport": 20848,
        "rpcport": 20849
    },
    "KMD": {
        "daemon": "komodod",
        "p2pport": 7770,
        "rpcport": 7771
    },
    "LTC": {
        "daemon": "litecoind",
        "p2pport": 9333,
        "rpcport": 9332
    },
    "CLC": {
        "daemon": "komodod",
        "p2pport": 20931,
        "rpcport": 20932
    },
    "GLEEC": {
        "daemon": "komodod",
        "p2pport": 23225,
        "rpcport": 23226
    },
    "ILN": {
        "daemon": "komodod",
        "p2pport": 12985,
        "rpcport": 12986
    },
    "NINJA": {
        "daemon": "komodod",
        "p2pport": 8426,
        "rpcport": 8427
    },
    "KOIN": {
        "daemon": "komodod",
        "p2pport": 10701,
        "rpcport": 10702
    },
    "PIRATE": {
        "daemon": "komodod",
        "p2pport": 45452,
        "rpcport": 45453
    },
    "SUPERNET": {
        "daemon": "komodod",
        "p2pport": 11340,
        "rpcport": 11341
    },
    "THC": {
        "daemon": "komodod",
        "p2pport": 36789,
        "rpcport": 36790
    },
    "DOC": {
        "daemon": "komodod",
        "p2pport": 62415,
        "rpcport": 62416
    },
    "MARTY": {
        "daemon": "komodod",
        "p2pport": 52592,
        "rpcport": 52593
    }
}

# Todo: add commit hashes for 3p coins
coins_3p = {
    "KMD_3P": {
        "daemon": "komodod",
        "p2pport": 8770,
        "rpcport": 8771
    },
    "AYA": {
        "daemon": "aryacoind",
        "p2pport": 26001,
        "rpcport": 9432
    },
    "CHIPS": {
        "daemon": "chipsd",
        "p2pport": 57776,
        "rpcport": 57777
    },
    "EMC2": {
        "daemon": "einsteiniumd",
        "p2pport": 41878,
        "rpcport": 41879
    },
    "MCL": {
        "daemon": "marmarad",
        "p2pport": 33824,
        "rpcport": 33825
    },
    "MIL": {
        "daemon": "mild",
        "p2pport": 41888,
        "rpcport": 41889
    },
    "TOKEL": {
        "daemon": "tokeld",
        "p2pport": 29404,
        "rpcport": 29405
    },
    "VRSC": {
        "daemon": "verusd",
        "p2pport": 27485,
        "rpcport": 27486
    }    
}

# Only using 3P coins in this repo
coins = list(coins_3p.keys())


def format_param(param, value):
    return f'-{param}={value}'


def generate_rpc_pass(length=24):
    special_chars = "@~-_|():+"
    rpc_chars = string.ascii_letters + string.digits + special_chars
    return "".join(secrets.choice(rpc_chars) for _ in range(length))


def get_coin_daemon(coin):
    if coin in coins_main:
        return coins_main[coin]["daemon"]
    elif coin in coins_3p:
        return coins_3p[coin]["daemon"]
    return f"no daemon for {coin}"


def get_data_path(coin):
    return os.path.split(get_conf_file(coin))[0]


def get_debug_file(coin, container=True) -> str:
    path = get_data_path(coin)
    if container:
        path = path.replace(home, "/home/komodian")
    return f"{path}/debug.log"


def get_conf_file(coin):
    if coin == 'AYA':
        conf_file = f"{home}/.aryacoin/aryacoin.conf"
    elif coin == 'CHIPS':
        conf_file = f"{home}/.chips/chips.conf"
    elif coin == 'EMC2':
        conf_file = f"{home}/.einsteinium/einsteinium.conf"
    elif coin == 'KMD':
        conf_file = f"{home}/.komodo/komodo.conf"
    elif coin == 'KMD_3P':
        conf_file = f"{home}/.komodo_3p/komodo.conf"
    elif coin == 'LTC':
        conf_file = f"{home}/.litecoin/litecoin.conf"
    elif coin == 'MCL':
        conf_file = f"{home}/.komodo_3p/MCL/MCL.conf"
    elif coin == 'MIL':
        conf_file = f"{home}/.mil/mil.conf"
    elif coin == 'TOKEL':
        conf_file = f"{home}/.komodo_3p/TOKEL/TOKEL.conf"
    elif coin == 'VRSC':
        conf_file = f"{home}/.komodo_3p/VRSC/VRSC.conf"
    else:
        conf_file = f"{home}/.komodo/{coin}/{coin}.conf"
    return conf_file


def get_cli_command(coin) -> str:
    if coin == 'AYA':
        return f"aryacoin-cli"
    if coin == 'CHIPS':
        return f"chips-cli"
    if coin == 'EMC2':
        return f"einsteinium-cli"
    if coin == 'KMD':
        return f"komodo-cli"
    if coin == 'KMD_3P':
        return f"komodo_3p-cli"
    if coin == 'LTC':
        return f"litecoin-cli"
    if coin == 'MCL':
        return f"marmara-cli"
    if coin == 'MIL':
        return f"mil-cli"
    if coin == 'TOKEL':
        return f"tokel-cli"
    if coin == 'VRSC':
        return f"verus-cli"
    return f"komodo-cli -ac_name={coin}"
  

def get_launch_params(coin):
    launch = get_coin_daemon(coin)
    if coin == 'KMD':
        launch += " -gen -genproclimit=1 -minrelaytxfee=0.000035 -opretmintxfee=0.004 -notary=.litecoin/litecoin.conf"
    elif coin == 'KMD_3P':
        launch += " -minrelaytxfee=0.000035 -opretmintxfee=0.004"
    for i in assetchains:
        if i["ac_name"] == coin:
            params = []
            for param, value in i.items():
                if isinstance(value, list):
                    for dupe_value in value:
                        params.append(format_param(param, dupe_value))
                else:
                    params.append(format_param(param, value))
            launch_str = ' '.join(params)
            launch += f" {launch_str}"
    launch += f" -pubkey=${{PUBKEY}}"
    return launch


def create_cli_wrappers():
    for coin in coins:
        cli = get_cli_command(coin)
        if "ac_name" in cli:
            wrapper = f"cli_wrappers/{coin.lower}-cli"
        else:
            wrapper = f"cli_wrappers/{cli}"
        # This is messy, but it works. Will make it cleaner later
        if coin == 'KMD_3P':
            cli = f"komodo-cli"
        with open(wrapper, 'w') as conf:
            conf.write('#!/bin/bash\n')
            conf.write(f'docker compose run {coin.lower()} {cli} "$@"\n')
            os.chmod(wrapper, 0o755)


def create_launch_files():
    for coin in coins:
        launch = get_launch_params(coin)
        launch_file = f"docker_files/launch_files/run_{coin}.sh"
        debug = get_debug_file(coin)
        # This is messy, but it works. Will make it cleaner later
        # inside container, komodo-cli is just komodo-cli
        coin = coin.split('_')[0]
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


def create_confs(server="third_party"):
    if server == "third_party":
        data = coins_3p
    else:
        data = coins_main
    coins = list(data.keys())
    for coin in coins:
        rpcuser = generate_rpc_pass()
        rpcpass = generate_rpc_pass()
        conf_file = get_conf_file(coin)
        data_path = get_data_path(coin)
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
            conf.write('addressindex=1\n')
            conf.write('spentindex=1\n')
            conf.write('server=1\n')
            conf.write('daemon=1\n')
            conf.write('rpcworkqueue=256\n')
            conf.write(f'rpcbind=0.0.0.0:{data[coin]["rpcport"]}\n')
            conf.write('rpcallowip=0.0.0.0/0\n')
            conf.write(f'port={data[coin]["p2pport"]}\n')
            conf.write(f'rpcport={data[coin]["rpcport"]}\n')
            conf.write('addnode=77.75.121.138 # Dragonhound_AR\n')
            conf.write('addnode=209.222.101.247 # Dragonhound_NA\n')
            conf.write('addnode=103.195.100.32 # Dragonhound_DEV\n')
            conf.write('addnode=104.238.221.61\n')
            conf.write('addnode=199.127.60.142\n')
        # create debug.log files if not existing
        debug_file = get_debug_file(coin, False)
        if not os.path.exists(debug_file):
            with open(debug_file, 'w') as f:
                f.write('')


def create_compose_yaml(server='thirty_party'):
    if server == 'thirty_party':
        shutil.copy('templates/docker-compose.template_3p', 'docker-compose.yml')
    else:
        # Not yet used in 3P repo
        shutil.copy('templates/docker-compose.template_main', 'docker-compose.yml')
        antara_coins = ["KMD", "DOC"]
        with open('docker-compose.yml', 'a+') as conf:
            for coin in antara_coins:
                if coin == 'KMD':
                    cli = "komodo-cli"
                else:
                    cli = "komodo-cli -ac_name={coin}"
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
                conf.write('        - COMMIT_HASH=156dba6\n')
                conf.write(f'        - SERVICE_CLI={cli}\n')
                conf.write('    ports:\n')
                conf.write(f'      - "127.0.0.1:{p2pport}:{p2pport}"\n')
                conf.write(f'      - "127.0.0.1:{rpcport}:{rpcport}"\n')
                conf.write('    volumes:\n')
                conf.write('      - <<: *zcash-params\n')      
                if coin == "KMD":
                    conf.write('      - /home/USERNAME/.komodo:/home/komodian/.komodo\n')
                else:
                    conf.write(f'      - /home/USERNAME/.komodo/{coin}:/home/komodian/.komodo/{coin}\n')
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

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('No arguments given, exiting.')
    elif sys.argv[1] == 'clis':
        create_cli_wrappers()
    elif sys.argv[1] == 'confs':
        create_confs()
    elif sys.argv[1] == 'launch':
        create_launch_files()
    elif sys.argv[1] == 'yaml':
        create_compose_yaml()
    else:
        print('Invalid option, must be in ["clis", "confs", "launch"]')
