#!/bin/bash
set -e 

mapfile -t HOSTS < <(jq -r '.dockerContexts[][1]' config.json)
mapfile -t NAMES < <(jq -r '.dockerContexts[][0]' config.json)

index=0
while [ "x${HOSTS[index]}" != "x" ]; do
    # Since everything in this repo is idempotent, but since docker context
    # returns a non-zero exit code if a context already exists (strange choice 
    # on their end, but I kind of see it), we temporarily allow failures for
    # this command. This does have the possibility of hiding a legitimate 
    # error, but I'm too lazy to make this script any fancier.
    set +e
    docker context create "${NAMES[index]}" --docker "${HOSTS[index]}"
    set -e
    index=$(( index + 1 ))
done


./print.sh "Docker contexts updated!"