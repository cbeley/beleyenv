#!/bin/bash
set -e 

curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# See https://github.com/yarnpkg/yarn/issues/2821
sudo apt-get update
sudo apt-get -y remove cmdtest

sudo apt-get install -y nodejs yarn

./print.sh "Node installed!"
