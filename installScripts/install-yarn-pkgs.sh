#!/usr/bin/env bash
set -e

# This will ensure global packages are installed
# in my home directory and allow me to share global
# packages when switching node versions (which may be
# problematic in some situations). 
yarn config set prefix ~/.yarn

PATH=$(yarn global bin):$PATH
export PATH

yarn global add eslint prettier tldr

# Update tldr cache now so we're good to go the first time we run it.
tldr -u

./print.sh "Installed general global yarn packages!"
