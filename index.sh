#!/bin/bash
set -e 

if [[ $OSTYPE == 'darwin'* ]]; then
    ./index.macos.sh
elif [[ -f "/etc/steamos-release" ]]; then
    ./index.steamos.sh
else
    ./index.chromeos.sh 
fi