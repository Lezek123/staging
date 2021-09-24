`nginx.conf` - example nginx setup with query-node, colossus and pioneer
`docker-compose.yml` - `joystream-node` configuration for `docker-compose`

Start an example network:
- Install `subkey` and `jq` (`./scripts/install-tools.sh`)
- Choose and build `joystream-node` docker image
- Run `./scripts/generate-keys.sh` to generate random sudo/validator seed (or export your own env variables)
- Run `./scripts/generate-spec.sh` to generate chain spec file
- Run `./scripts/setup-keys.sh` to setup validator keys
- Run `docker-compose up -d joystream-node` to start the node
- Run `docker-compose logs joystream-node` and look for node id (`Local node identity is: 12D3KooWMexTZ3yTxS3c4pyg6fpb1fREP2249h7Yvrqbt7c8Rdxb`)

On other machine:
Copy generated `./scripts/data/chain-spec-raw.json` from the first machine.
Start the second node with:
`--bootnodes /ip4/127.0.0.1/tcp/30333/p2p/12D3KooWAvdwXzjmRpkHpz8PzUTaX1o23SdpgAWVyTGMSQ68QXK6` (use the node id of the first node)
`--chain /path/to/chain-spec-raw.json`
In order to join the network

More instructions can be found here: https://substrate.dev/docs/en/tutorials/start-a-private-network/customchain