#!/usr/bin/env bash
set -e

SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"
cd $SCRIPT_PATH

CHAIN_DIR="$(cd .. && pwd)/chain"

SEED=$(jq -r .seed ./data/keys.json)
PUBLIC_KEY_SR=$(jq -r .publicKeySr ./data/keys.json)
PUBLIC_KEY_ED=$(jq -r .publicKeyEd ./data/keys.json)

CONTAINER_ID=`docker run -d -p 127.0.0.1:9933:9933 -v $CHAIN_DIR:/chain joystream/node:latest \
	--base-path /chain \
	--chain /chain/spec.json \
	--validator \
	--rpc-methods Unsafe \
	--rpc-port 9933 \
	--log runtime \
	--no-telemetry \
	--unsafe-rpc-external`

function cleanup() {
    docker logs ${CONTAINER_ID} --tail 15
    docker stop ${CONTAINER_ID}
    docker rm ${CONTAINER_ID}
}

trap cleanup EXIT

sleep 10

curl http://localhost:9933 -H "Content-Type:application/json;charset=utf-8" -d "{
  \"jsonrpc\": \"2.0\",
  \"id\": 1,
  \"method\": \"author_insertKey\",
  \"params\": [
    \"babe\",
    \"//$SEED\",
    \"$PUBLIC_KEY_SR\"
  ]
}"

curl http://localhost:9933 -H "Content-Type:application/json;charset=utf-8" -d "{
  \"jsonrpc\": \"2.0\",
  \"id\": 1,
  \"method\": \"author_insertKey\",
  \"params\": [
    \"gran\",
    \"//$SEED\",
    \"$PUBLIC_KEY_ED\"
  ]
}"

curl http://localhost:9933 -H "Content-Type:application/json;charset=utf-8" -d "{
  \"jsonrpc\": \"2.0\",
  \"id\": 1,
  \"method\": \"author_insertKey\",
  \"params\": [
    \"imon\",
    \"//$SEED\",
    \"$PUBLIC_KEY_ED\"
  ]
}"