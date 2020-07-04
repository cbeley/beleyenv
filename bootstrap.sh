#!/bin/bash
set -e 

sudo apt-get update
sudo apt-get install git-crypt

# Install the commit hook that should probally be a part of git-crypt
# that prevents commiting unencrypted files.
cp pre-commit-hook .git/hooks/pre-commit

if [[ "$(pwd)" != "$HOME/.beleyenv/beleyenv" ]]; then
	mkdir -p ~/.beleyenv

	echo "Moving your git repo to the .beleyenv folder"
	mv ../beleyenv ~/.beleyenv/
fi


read -sp 'git-crypt secret key:' secretKey

# Inspired by
# https://unix.stackexchange.com/questions/352569/converting-from-binary-to-hex-and-back
echo $secretKey | sed 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI' \
	| xargs -I {} printf {} > ~/.beleyenv/secretKey 

git-crypt unlock ~/.beleyenv/secretKey