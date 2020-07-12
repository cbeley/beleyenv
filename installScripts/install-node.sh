#!/bin/bash
set -e 

# See https://github.com/yarnpkg/yarn/issues/2821
sudo apt-get remove cmdtest

curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get install -y nodejs yarn

./print.sh "Node installed!"
