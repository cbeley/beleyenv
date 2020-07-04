#!/bin/bash
set -e 

sudo apt-get update
sudo apt-get install git-crypt

# Install the commit hook that should probally be a part of git-crypt
# that prevents commiting unencrypted files.
wget https://gist.githubusercontent.com/Falkor/848c82daa63710b6c132bb42029b30ef/raw/610bac85ca512171d04b19d668098bd2678559a7/pre-commit.git-crypt.sh -O .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

if [[ "$(pwd)" != "$HOME/.beleyenv/beleyenv" ]]; then
	mkdir -p ~/.beleyenv

	echo "Moving your git repo to the .beleyenv folder"
	mv ../beleyenv ~/.beleyenv/
fi



# TODO: Prompt to enter key.

git-crypt unlock ~/.beleyenv/secretKey