#!/bin/bash
set -e 

if [[ $OSTYPE == 'darwin'* ]]; then
    ./index.macos.sh
elif [[ -f "/etc/steamos-release" ]]; then
    ./index.steamos.sh
elif grep -q 'debian\|ubuntu' /etc/os-release; then 
    ./index.linux-common.sh 
else 
    echo 'Unsupported environment.'
    
    exit 1
fi