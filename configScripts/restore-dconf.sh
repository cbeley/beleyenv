#!/usr/bin/env bash

set -e

mapfile -t dconfPaths < <(jq -r '.dconfPaths[]' config.json)

index=0
while [ "x${dconfPaths[index]}" != "x" ]; do
    echo "Restoring dconf path: ${dconfPaths[index]}"
    
    serializedFilePath=$(echo "${dconfPaths[index]}" | sed 's/\//-/g')

    dconf load "/${dconfPaths[index]}/" < "configs/dconf/$serializedFilePath"

    index=$(( index + 1 ))
done