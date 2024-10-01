source userpass
source rpc
curl --url "$url:$port" --data "{\"method\":\"version\",\"userpass\":\"$userpass\"}"
echo ""
