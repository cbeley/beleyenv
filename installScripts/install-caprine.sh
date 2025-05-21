#!/usr/bin/env bash 
set -e 

echo \
    "deb [trusted=yes] https://apt.fury.io/lefterisgar/ * *" \
     | sudo tee /etc/apt/sources.list.d/caprine.list > /dev/null

sudo apt-get update
sudo apt-get install caprine