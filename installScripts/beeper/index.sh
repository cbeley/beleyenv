#!/bin/bash
set -e 

source ./devScripts/temp-handler.sh
sudo mkdir -p /usr/local/beleyenv/beeper/bin

(
    cd temp
    wget -O beeper https://download.beeper.com/linux/appImage/x64
    chmod +x beeper
    sudo mv beeper /usr/local/beleyenv/beeper/bin/
)

sudo cp installScripts/beeper/icon.png /usr/local/beleyenv/beeper/
sudo cp installScripts/beeper/beeper.desktop /usr/local/beleyenv/beeper/

sudo ln -sf /usr/local/beleyenv/beeper/bin/beeper /usr/local/bin/
sudo ln -fs /usr/local/beleyenv/beeper/beeper.desktop /usr/local/share/applications/
