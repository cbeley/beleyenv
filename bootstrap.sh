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



# TODO: Prompt to enter key.

git-crypt unlock ~/.beleyenv/secretKey