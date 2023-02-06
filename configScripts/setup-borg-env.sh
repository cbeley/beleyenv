#!/bin/bash
set -e 

# This is required by installScripts/installBorgTools.  Separated as a matter of
# convention and also because we want to keep all user prompting to the beginning
# of the main install script.

mkdir -p ~/.beleyenv
rm -f ~/.beleyenv/borg-env ~/.beleyenv/borg-env.export
touch ~/.beleyenv/borg-env ~/.beleyenv/borg-env.export

BORG_REPO=$(jq -r ".borg.repo.$1" config.json)

read -rsp 'Borg Passphrase:' BORG_PASSPHRASE

echo "BORG_REPO=\"${BORG_REPO}\"" >> ~/.beleyenv/borg-env
echo "BORG_PASSPHRASE=\"${BORG_PASSPHRASE}\"" >> ~/.beleyenv/borg-env

echo "export BORG_REPO=\"${BORG_REPO}\"" >> ~/.beleyenv/borg-env.export
echo "export BORG_PASSPHRASE=\"${BORG_PASSPHRASE}\"" >> ~/.beleyenv/borg-env.export

./print.sh "Borg Environment Setup!"