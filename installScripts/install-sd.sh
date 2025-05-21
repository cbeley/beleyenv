#!/usr/bin/env bash
set -e 

rm -rf temp
mkdir temp

(
    cd temp

    curl -s https://api.github.com/repos/chmln/sd/releases/latest \
        | jq -r '[.assets[].browser_download_url] 
            | map(select(endswith("linux-gnu")))
            | .[0]' \
        | xargs wget -O sd

    chmod +x sd

    sudo mkdir -p /usr/local/beleyenv/bin
    sudo cp sd /usr/local/beleyenv/bin/
    sudo ln -sf /usr/local/beleyenv/bin/sd /usr/local/bin/
)

rm -rf temp

./print.sh "sd symlinked to /usr/local/bin/"