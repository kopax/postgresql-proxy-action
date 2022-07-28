#!/bin/sh

# start SSH agent and load key
source agent-start "$GITHUB_ACTION"
echo "$INPUT_REMOTE_KEY" | SSH_PASS="$INPUT_REMOTE_KEY_PASS" agent-add

# turn on strict errors
set -eu

# list interfaces
sh -c "ifconfig"

#sh -c "ssh -o StrictHostKeyChecking=no -f -N -L localhost:$INPUT_POSTGRE_PORT:$INPUT_POSTGRE_HOST:$INPUT_POSTGRE_PORT -p $INPUT_REMOTE_PORT $INPUT_REMOTE_USER@$INPUT_REMOTE_HOST $INPUT_SWITCHES"
