source userpass
source rpc
curl --url "$url:$port" --data "{\"mmrpc\": \"2.0\",\"method\":\"remove_node_from_version_stat\",\"userpass\":\"$userpass\",\"params\":{\"name\": \"$1\"}}"
echo ""
