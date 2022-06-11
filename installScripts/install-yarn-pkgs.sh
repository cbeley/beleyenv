#!/bin/bash
set -e

runYarn () {
    # No sudo on MacOS. Would need to make some bigger
    # changes on the Debian side to fix ths.
    

    if [[ $OSTYPE == 'darwin'* ]]; then
        yarn "$@"
    else
        sudo yarn "$@"
    fi
}

runYarn global add eslint prettier tldr

# Update tldr cache now so we're good to go the first time we run it.
tldr -u

./print.sh "Installed general global yarn packages!"