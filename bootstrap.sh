#!/bin/bash
set -e 

if [[ -f "/etc/steamos-release" ]]; then
	# password needs to be set for sudo access needed by homebrew.
	
	if passwd -S | awk '{print $2}' | grep 'NP' > /dev/null; then
    	echo 'Password was not set.'
    	passwd
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

	brew install git-crypt
elif [[ $OSTYPE == 'darwin'* ]]; then
	# Not ideal to have to deal with installing brew in bootstrap,
	# but no package manager otherwise to get git-crypt, which is required
	# for beleyenv to run.
	
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	eval "$(/opt/homebrew/bin/brew shellenv)"

	brew install git-crypt coreutils findutils

	PATH="$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH"
	PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
else
	sudo apt-get update
	sudo apt-get install git-crypt
fi

./devScripts/install-commit-hook.sh

if [[ "$(pwd)" != "$HOME/.beleyenv/beleyenv" ]]; then
	mkdir -p ~/.beleyenv

	echo "Moving your git repo to the .beleyenv folder"
	mv ../beleyenv ~/.beleyenv/
fi


read -rsp 'git-crypt secret key:' secretKey

# Inspired by
# https://unix.stackexchange.com/questions/352569/converting-from-binary-to-hex-and-back
echo "$secretKey" | sed 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI' \
	| xargs -I {} printf {} > ~/.beleyenv/secretKey 

git-crypt unlock ~/.beleyenv/secretKey