#!/usr/bin/env bash
set -e 

curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -

# See https://github.com/yarnpkg/yarn/issues/2821
sudo apt-get update
sudo apt-get -y remove cmdtest yarn

sudo apt-get install -y nodejs

sudo npm install -g yarn

./print.sh "Node installed!"
