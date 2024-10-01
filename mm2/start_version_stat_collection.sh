source userpass
source rpc
curl --url "$url:$port" --data "{\"mmrpc\": \"2.0\",\"method\":\"start_version_stat_collection\",\"userpass\":\"$userpass\",\"params\":{\"interval\": 60}}"
echo ""
