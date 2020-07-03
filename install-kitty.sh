#!/bin/bash 
set -e

rm -rf temp
mkdir -p temp

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=./temp/ launch=n

cp kitty.desktop temp/kitty.app/share/applications/

sudo mkdir -p /usr/local/opt
sudo mkdir -p /usr/local/share/applications

sudo cp -R temp/kitty.app /usr/local/opt
sudo ln -fs /usr/local/opt/kitty.app/bin/kitty /usr/local/bin/kitty
sudo ln -fs /usr/local/opt/kitty.app/share/applications/kitty.desktop /usr/local/share/applications/kitty.desktop

echo "Kitty installed!"
