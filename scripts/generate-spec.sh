#!/usr/bin/env bash
set -e

export SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"
cd $SCRIPT_PATH

export SEED=$(jq -r .seed ./data/keys.json)
export ADDR_SR=$(jq -r .addrSr ./data/keys.json)

echo "{
  \"balances\": [
    [
      \"${ADDR_SR}\",
      100000000
    ]
  ]
}" > ./data/balances.json

docker run --rm -v $(pwd)/data:/data --env SEED="${SEED}" --env ADDR_SR="${ADDR_SR}" --entrypoint ./chain-spec-builder joystream/node:latest \
  new \
  --authority-seeds ${SEED} \
  --sudo-account ${ADDR_SR} \
  --deployment dev \
  --initial-balances-path /data/balances.json \
  --chain-spec-path /data/chain-spec.json

docker run --rm -v $(pwd)/data:/data joystream/node:latest build-spec \
  --raw --disable-default-bootnode \
  --chain /data/chain-spec.json > $(pwd)/data/chain-spec-raw.json

# Copy to docker-mounted location
cp ./data/chain-spec-raw.json ../chain/spec.json