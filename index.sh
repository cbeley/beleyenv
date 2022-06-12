#!/bin/bash
set -e 

if [[ $OSTYPE == 'darwin'* ]]; then
    ./index.macos.sh 
else
    ./index.linux.sh 
fi