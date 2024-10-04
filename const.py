#!/usr/bin/env python3
import json
import os


home = os.path.expanduser('~')
script_path = os.path.realpath(os.path.dirname(__file__))
dpow_path = os.path.join(home, "dPoW")

# Todo: add commit hashes for 3p coins
coins_3p = {
    "KMD_3P": {
        "daemon": "komodod",
        "p2pport": 8770,
        "rpcport": 8771
    },
    "MCL": {
        "daemon": "marmarad",
        "p2pport": 33824,
        "rpcport": 33825
    },
    "TOKEL": {
        "daemon": "tokeld",
        "p2pport": 29404,
        "rpcport": 29405
    }
}

# Only using 3P coins in this repo
coins = list(coins_3p.keys())

