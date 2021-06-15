#!/bin/bash
set -e
trap 'ctrlC' INT
trap 'theEnd $?' EXIT

ctrlC() {
	./print.sh "You canceled beleyenv!  This may leave you in a weird state.\n\
Since belyenv is idempotent, you can most likely just re-run beleyenv"

	exit 1
}

theEnd() {
	if [[ "$1" != "0" ]]; then
		./print.sh 'Beleyenv install failed!'

		if command -v notify-send &> /dev/null; then
			notify-send -a 'beleyenv' 'beleyenv install failed!' 'You are probally now very sad.'
		fi
	else
		./print.sh 'SUCCESS!  BELEYENV HAS BEEN FULLY INSTALLED!'

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
	python3-dev python3-setuptools git zsh jq shellcheck git-cola imagemagick borgbackup \
	ca-certificates gnupg-agent software-properties-common vlc traceroute gimp rsync \
	dnsutils dnsmasq gocryptfs

./print.sh "Installed general apt-get packages!"

# Install Pip dependencies
# pygments is required by https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
sudo pip3 install deluge thefuck pygments

./print.sh "Installed general pip packages!"

# Install Flatpak repositories & packages
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub com.valvesoftware.Steam

# This may be undesirable on 1080p screens.
flatpak override --user --env=GDK_SCALE=3 com.valvesoftware.Steam

./print.sh "Installed flatpak & flatpak packages!"

# Package installs that require more effort -- mostly because debian LTS tends to have
# very old packages.
./installScripts/installKitty/index.sh
./installScripts/install-zsh.sh
./installScripts/installSublime/index.sh
./installScripts/install-todo.sh
./installScripts/install-lsd.sh
./installScripts/install-fonts.sh
./installScripts/install-hostess.sh
./installScripts/install-docker.sh
./installScripts/install-theme.sh
./installScripts/install-node.sh
./installScripts/install-lazygit.sh
./installScripts/install-delta.sh

# Install yarn dependencies
sudo yarn global add eslint prettier

./print.sh "Installed general global yarn packages!"

# User configuration
./configScripts/link-configs.sh
./configScripts/update-hosts.sh
./configScripts/setup-git.sh

# Install packages dependent on user configuration being present first.
./installScripts/installBorgTools/index.sh
./installScripts/install-etc-hosts-watcher.sh

./print.sh "Hints of what to do next:\n\
 * Run ./devScripts/switch-to-ssh-remote.sh to switch from https to ssh if you are Chris\n\
 * Some changes only will take effect after a reboot of the container. Run sudo poweroff then start kitty via the app launcher.\n\
 * You will have to manually run the "Install Package Control" command in sublime."
