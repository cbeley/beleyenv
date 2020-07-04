#!/bin/bash 
set -e

if [[ $TERM -eq "xterm-kitty" ]]; then
	echo "[WARN] You are currently running kitty, so instalation of it was skipped."
	echo "[WARN] Run ./installScrips/installKitty/index.sh in a differnt terminal if you would like to upgrade kitty."
	echo "Skipping kitty install..."

	notify-send -a "beleyenv" "[WARN] Skipping install/upgrade of kitty"
	exit 0
fi

rm -rf temp
mkdir -p temp

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=./temp/ launch=n

cp installScripts/installKitty/kitty.desktop temp/kitty.app/share/applications/

sudo mkdir -p /usr/local/opt
sudo mkdir -p /usr/local/share/applications

sudo cp -R temp/kitty.app /usr/local/opt
sudo ln -fs /usr/local/opt/kitty.app/bin/kitty /usr/local/bin/kitty
sudo ln -fs /usr/local/opt/kitty.app/share/applications/kitty.desktop /usr/local/share/applications/kitty.desktop

echo "Kitty installed!"
