#!/usr/bin/env bash
set -e 

rm -rf temp
mkdir temp
cd temp

curl -s https://api.github.com/repos/cbednarski/hostess/releases/latest \
	| jq -r '[.assets[].browser_download_url] 
		| map(select(endswith("linux_amd64")))
		| .[0]' \
	| xargs wget -O hostess

chmod +x hostess

sudo mkdir -p /usr/local/beleyenv/bin
sudo cp hostess /usr/local/beleyenv/bin/
sudo ln -sf /usr/local/beleyenv/bin/hostess /usr/local/bin/

../print.sh "Hostess symlinked to /usr/local/bin/"