#!/bin/bash
set -e 

sudo mkdir -p /usr/local/beleyenv/bin

curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
    | jq -r '[.assets[].browser_download_url] 
        | map(select(endswith("Linux_x86_64.tar.gz")))
        | .[0]' \
    | xargs curl -L \
    | sudo tar -C /usr/local/beleyenv/bin/ -zxv lazygit

sudo ln -sf /usr/local/beleyenv/bin/lazygit /usr/local/bin/

./print.sh "Lazygit symlinked to /usr/local/bin"