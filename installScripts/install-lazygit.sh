#!/bin/bash
set -e 

curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
    | jq -r '[.assets[].browser_download_url] 
        | map(select(endswith("Linux_x86_64.tar.gz")))
        | .[0]' \
    | xargs curl -L \
    | sudo tar -C /usr/local/bin/ -zxv lazygit

./print.sh "Lazygit installed to /usr/local/bin"