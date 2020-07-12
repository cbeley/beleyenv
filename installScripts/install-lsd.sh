#!/bin/bash
set -e 

rm -rf temp
mkdir temp
cd temp

curl -s https://api.github.com/repos/Peltoche/lsd/releases/latest \
	| jq -r '[.assets[].browser_download_url] 
		| map(select(endswith("amd64.deb") and (contains("musl") | not)))
		| .[0]' \
	| xargs wget

sudo dpkg -i ./*.deb

../print.sh "lsd installed!"