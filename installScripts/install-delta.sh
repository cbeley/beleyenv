#!/bin/bash
set -e 

rm -rf temp
mkdir temp
cd temp

# TODO: switch to latest delta once https://github.com/jesseduffield/lazygit/issues/893
# is fixed.
curl -s https://api.github.com/repos/dandavison/delta/releases/25901943 \
    | jq -r '[.assets[].browser_download_url] 
        | map(select(endswith("amd64.deb") and (contains("musl") | not)))
        | .[0]' \
    | xargs wget

sudo dpkg -i ./*.deb

../print.sh "Delta installed!"