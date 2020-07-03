#!/bin/bash
set -e 

curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get install -y nodejs yarn

echo "Node installed!"