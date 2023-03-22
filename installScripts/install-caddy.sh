#!/bin/bash 
set -e 

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | \
    sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
    | sudo tee /etc/apt/sources.list.d/caddy-stable.list \
    > /dev/null

sudo apt update
sudo apt install caddy

# I just want to use it for dev work. The default
# is to start and enable it apparently though.
sudo systemctl stop caddy 
sudo systemctl disable caddy