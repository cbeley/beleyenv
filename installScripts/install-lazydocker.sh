#!/bin/bash
set -e 

sudo mkdir -p /usr/local/beleyenv/bin

curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest \
    | jq -r '[.assets[].browser_download_url] 
        | map(select(endswith("Linux_x86_64.tar.gz")))
        | .[0]' \
    | xargs curl -L \
    | sudo tar -C /usr/local/beleyenv/bin/ -zxv lazydocker

sudo ln -sf /usr/local/beleyenv/bin/lazydocker /usr/local/bin/

./print.sh "Lazydocker symlinked to /usr/local/bin"