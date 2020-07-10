#!/bin/bash
set -e 

# This script is separated, since we want to keep all prompting to the beginning
# of the main script.  You may also wish to upgrade borg and the scripts without
# wiping your env file.

mkdir -p ~/.beleyenv
rm -f ~/.beleyenv/borg-env
touch ~/.beleyenv/borg-env

BORG_REPO=$(jq -r '.borgRepo' config.json)

read -sp 'Borg Passphrase:' BORG_PASSPHRASE

echo "BORG_REPO=\"${BORG_REPO}\"" >> ~/.beleyenv/borg-env
echo "BORG_PASSPHRASE=\"${BORG_PASSPHRASE}\"" >> ~/.beleyenv/borg-env
