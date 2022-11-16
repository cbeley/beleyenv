#!/bin/bash 
set -e

if [[ ${TERM:?} = "xterm-kitty" ]]; then
	./print.sh "[WARN] You are currently running kitty, so installation of it was skipped.\n\
[WARN] Run ./installScrips/installKitty/index.sh in a different terminal if you would like to upgrade kitty.\n\
Skipping kitty install..."

	notify-send -a "beleyenv" "[WARN] Skipping install/upgrade of kitty"
	exit 0
fi

rm -rf temp
mkdir -p temp

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=./temp/ launch=n

cp installScripts/installKitty/kitty.desktop temp/kitty.app/share/applications/

sudo mkdir -p /usr/local/share/applications
sudo mkdir -p /usr/local/beleyenv

sudo cp -R temp/kitty.app /usr/local/beleyenv/
sudo ln -fs /usr/local/beleyenv/kitty.app/bin/kitty /usr/local/bin/
sudo ln -fs /usr/local/beleyenv/kitty.app/share/applications/kitty.desktop /usr/local/share/applications/

# Clean up after so shellcheck doesn't fail/no unexpected files in beleyenv folder.
rm -rf temp

./print.sh "Kitty installed!"
