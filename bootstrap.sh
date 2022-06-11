#!/bin/bash
set -e 

if [[ $OSTYPE == 'darwin'* ]]; then
	# Not ideal to have to deal with installing brew in bootstrap,
	# but no package manager otherwise to get git-crypt, which is required
	# for beleyenv to run.
	
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	brew install git-crypt
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