#!/bin/bash
set -e
trap 'ctrlC' INT
trap 'theEnd $?' EXIT

ctrlC() {
	echo "You canceled beleyenv!  This may leave you in a weird state."
	echo "Since belyenv is idempotent, you can most likely just re-run beleyenv"
	exit 1
}

theEnd() {
	if [[ "$1" != "0" ]]; then
		echo 'Beleyenv install failed!'

		if command -v notify-send &> /dev/null; then
			notify-send -a 'beleyenv' 'beleyenv install failed!' 'You are probally now very sad.'
		fi
	else
		echo 'SUCCESS!  BELEYENV HAS BEEN FULLY INSTALLED!'

		if command -v notify-send &> /dev/null; then
			notify-send -a 'beleyenv' 'beleyenv install finished!' 'Have fun!'
		fi
	fi
}

sudo apt update

# Install the minimum for the few things that require
# prompting the user to do something.
sudo apt-get -y install jq libnotify-bin

./configScripts/setup-ssh-keys.sh 
./configScripts/setup-borg-env.sh

sudo apt-get -y dist-upgrade

### Everything below this line should require zero prompting from the user ###

sudo apt-get -y install xz-utils nano apt-transport-https flatpak python3-pip \
	python3-libtorrent python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-appindicator3 \
	python3-dev python3-setuptools git zsh jq shellcheck git-cola imagemagick borgbackup

# Install Pip dependencies
# pygments is required by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
sudo pip3 install deluge thefuck pygments

# Install Flatpak repositories & packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub com.valvesoftware.Steam

# Package installs that require more effort -- mostly because debian LTS tends to have
# very old packages.
./installScripts/installKitty/index.sh
./installScripts/install-zsh.sh
./installScripts/installSublime/index.sh
./installScripts/install-todo.sh
./installScripts/install-lsd.sh
./installScripts/install-fonts.sh
./installScripts/install-node.sh
./installScripts/install-hostess.sh

# Install yarn dependencies
sudo yarn global add eslint prettier

# User configuration
./configScripts/link-configs.sh
./configScripts/update-hosts.sh
./configScripts/setup-git.sh

# Install packages dependent on user configuration being present first.
./installScripts/installBorgTools/index.sh

# Still working on themeing
# ./install-theme.sh

echo 'SUCCESS!  BELEYENV HAS BEEN FULLY INSTALLED!'
notify-send -a 'beleyenv' 'beleyenv install finished!' 'Have fun!'