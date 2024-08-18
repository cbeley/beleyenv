#!/bin/bash 
set -e 

curl -fsSL https://packagecloud.io/filips/FirefoxPWA/gpgkey \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/firefoxpwa-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/firefoxpwa-keyring.gpg] https://packagecloud.io/filips/FirefoxPWA/any any main" \
    | sudo tee /etc/apt/sources.list.d/firefoxpwa.list > /dev/null

sudo apt-get update
sudo apt-get install firefoxpwa