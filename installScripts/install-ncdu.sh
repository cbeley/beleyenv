#!/bin/bash
set -e 

sudo mkdir -p /usr/local/beleyenv/bin

curl -s https://dev.yorhel.nl/download/ncdu-2.2.1-linux-x86_64.tar.gz \
    | sudo tar -C /usr/local/beleyenv/bin/ -zxv ncdu

sudo ln -sf /usr/local/beleyenv/bin/ncdu /usr/local/bin/

./print.sh "ncdu symlinked to /usr/local/bin"