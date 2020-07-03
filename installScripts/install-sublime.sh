#!/bin/bash
set -e 

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text

SUBLIME_LICENSE=$(jq -r '.sublimeLicense' config.json)
echo -e "$SUBLIME_LICENSE" > ~/.config/sublime-text-3/Local/License.sublime_license

echo "Sublime text installed with license!"