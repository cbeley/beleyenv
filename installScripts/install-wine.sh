#!/bin/bash
set -e 

source ./devScripts/temp-handler.sh

sudo apt-get -y install wine64

(
    cd temp

    wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks

    chmod +x winetricks

    sudo mkdir -p /usr/local/beleyenv/bin
    sudo cp winetricks /usr/local/beleyenv/bin/
    sudo ln -sf /usr/local/beleyenv/bin/winetricks /usr/local/bin/
)

./print.sh "winetricks symlinked to /usr/local/bin/"