#!/usr/bin/env bash
set -e 

rm -rf temp
mkdir temp
cd temp

curl -Ls https://api.github.com/repos/dandavison/delta/releases/latest \
    | jq -r '[.assets[].browser_download_url] 
        | map(select(endswith("amd64.deb") and (contains("musl") | not)))
        | .[0]' \
    | xargs wget

sudo dpkg -i ./*.deb
rm -rf temp

../print.sh "Delta installed!"