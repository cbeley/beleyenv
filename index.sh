#!/bin/bash
set -e 

if [[ $OSTYPE == 'darwin'* ]]; then
    ./index.macos.sh
elif grep -q 'ubuntu' /etc/os-release; then
    ./index.ubuntu.sh
elif [[ -f "/etc/steamos-release" ]]; then
    ./index.steamos.sh
elif grep -q 'debian' /etc/os-release; then 
    ./index.chromeos.sh 
else 
    echo 'Unsupported environment.'
    
    exit 1
fi