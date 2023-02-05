#!/bin/bash

set -e

cd "$HOME/.beleyenv/beleyenv"

mapfile -t dconfPaths < <(jq -r '.dconfPaths[]' config.json)

index=0
while [ "x${dconfPaths[index]}" != "x" ]; do
    echo "Backing up dconf path: ${dconfPaths[index]}"

    serializedFilePath=$(echo "${dconfPaths[index]}" | sed 's/\//-/g')

    dconf dump "/${dconfPaths[index]}/" > "configs/dconf/$serializedFilePath"
    index=$(( index + 1 ))
done