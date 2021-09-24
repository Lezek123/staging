#!/usr/bin/env bash
# Generates a random seed for sudo/validator and sets it 
set -e

SCRIPT_PATH="$(dirname "${BASH_SOURCE[0]}")"
cd $SCRIPT_PATH

SEED=$(openssl rand --hex 32)
PUBLIC_KEY_SR=$(subkey inspect //$SEED | sed -n 3p | grep -Eo "[A-Za-z0-9]+$")
PUBLIC_KEY_ED=$(subkey inspect //$SEED --scheme ed25519 | sed -n 3p | grep -Eo "[A-Za-z0-9]+$")
ADDR_SR=$(subkey inspect //$SEED | sed -n 5p | grep -Eo "[A-Za-z0-9]+$")
ADDR_ED=$(subkey inspect //$SEED --scheme ed25519 | sed -n 5p | grep -Eo "[A-Za-z0-9]+$")

KEYS="{
    \"seed\": \"$SEED\",
    \"publicKeySr\": \"$PUBLIC_KEY_SR\",
    \"publicKeyEd\": \"$PUBLIC_KEY_ED\",
    \"addrSr\": \"$ADDR_SR\",
    \"addrEd\": \"$ADDR_ED\"
}"

echo $KEYS > ./data/keys.json
