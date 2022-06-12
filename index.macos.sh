#!/bin/bash

# Note that this is not really meant to be identical to index.linux.sh, since
# I use MacOS and ChromeOS for different purposes.
 
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
    else
        ./print.sh 'SUCCESS!  BELEYENV HAS BEEN FULLY INSTALLED!'
    fi
}

# TODO SSH Key Gen - May not automate this for MacOS. Thinking on it.
#./configScripts/setup-ssh-keys.sh 

# Note: Will prompt if not installed.
if ! command -v gcc &> /dev/null; then
    xcode-select --install
fi

### Everything below this line should require zero prompting from the user ###

# Brew should be installed by bootstrap.sh,
# so we just update the local repo and upgrade packages.
brew update
brew upgrade

# Use GNU Tools
# Inspired by https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
brew install autoconf bash binutils coreutils diffutils ed findutils flex gawk \
    gnu-indent gnu-sed gnu-tar gnu-which gpatch grep gzip less m4 make nano \
    screen watch wdiff wget

# Allow for use of these tools immediately. 
# From https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
# TODO: Cleanup.
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  NEWPATH=${PATH}
  # gnubin; gnuman
  for d in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnubin; do NEWPATH=$d:$NEWPATH; done
  # I actually like that man grep gives the BSD grep man page
  #for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
  PATH=$(echo "${NEWPATH}" | tr ':' '\n' | cat -n | sort -uk2 | sort -n | cut -f2- | xargs | tr ' ' ':')
  export PATH
fi

# TODO: Ensure zsh sets up PATH correctly for this.

# Meant to mirror what is installed in apt-get in index.linux.sh as
# much as possible (and as relevant for my macOS use-cases).
brew install rsync zsh shellcheck imagemagick fd unrar thefuck jq
brew install --cask gimp vlc

# Meant to mirror the install scripts, though most are handled with brew.
# Debating how to maintain this going forward.

# Replaces ./installScripts/installKitty/index.sh
brew install --cask kitty

# Replaces ./installScripts/installSublime/index.sh
brew install --cask sublime-text

# Replaces ./installScripts/install-lsd.sh
brew install lsd

# Replaces ./installScripts/install-lazygit.sh
brew install lazygit

# Replaces ./installScripts/install-delta.sh
brew install git-delta

# ./installScripts/install-todo.sh
# ./installScripts/install-hostess.sh
# ./installScripts/install-docker.sh
# ./installScripts/install-theme.sh
# ./installScripts/install-node.sh

./installScripts/install-fonts.sh
./installScripts/install-zsh.sh
./installScripts/install-yarn-pkgs.sh

# MacOS Specific Software
brew install --cask rectangle

# User configuration
./configScripts/link-configs.sh

# TODO: write install scripts for/update
# * Replace python with python installed from cask