source userpass
source rpc
curl --url "$url:$port" --data "{
    \"mmrpc\": \"2.0\",
    \"method\":\"add_node_to_version_stat\",
    \"userpass\":\"$userpass\",
    \"params\":{\"name\": \"${1}\",
    \"address\": \"${2}\",
    \"peer_id\": \"${3}\"}
}"
echo ""
