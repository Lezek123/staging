# https://substrate.dev/docs/en/knowledgebase/integrate/subkey
curl https://getsubstrate.io -sSf | bash -s -- --fast 
cargo install --force subkey --git https://github.com/paritytech/substrate --version 2.0.1 --locked
# jq
sudo apt-get install jq -y