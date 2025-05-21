#!/usr/bin/env bash

set -e

if [[ $OSTYPE == 'darwin'* ]]; then
    brew install --cask signal

    exit 0;
fi

wget -O- https://updates.signal.org/desktop/apt/keys.asc | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg \
    > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
sudo tee /etc/apt/sources.list.d/signal-xenial.list > /dev/null

sudo apt-get update
sudo apt-get -y install signal-desktop