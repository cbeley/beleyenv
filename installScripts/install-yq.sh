#!/bin/bash
set -e 

rm -rf temp
mkdir temp
cd temp

curl -s https://api.github.com/repos/mikefarah/yq/releases/latest \
    | jq -r '[.assets[].browser_download_url] 
        | map(select(endswith("linux_amd64")))
        | .[0]' \
    | xargs wget -O yq

chmod +x yq

sudo mkdir -p /usr/local/beleyenv/bin
sudo cp yq /usr/local/beleyenv/bin/
sudo ln -sf /usr/local/beleyenv/bin/yq /usr/local/bin/

../print.sh "yq symlinked to /usr/local/bin/"