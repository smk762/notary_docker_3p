#!/usr/bin/env python3
import json
import os


home = os.path.expanduser('~')
script_path = os.path.realpath(os.path.dirname(__file__))
dpow_path = os.path.join(home, "dPoW")

with open(f'{dpow_path}/iguana/assetchains.json') as file:
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
        "daemon": "komodod",
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

