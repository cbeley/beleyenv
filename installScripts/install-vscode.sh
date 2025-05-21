#!/usr/bin/env bash 

set -e

source ./devScripts/temp-handler.sh

(
    cd temp
    wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    
    # Note that this should install everything needed for updates.
    sudo apt install ./vscode.deb
)

./print.sh "VS Code Installed"