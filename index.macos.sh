#!/bin/bash

# Note that this is not really meant to be identical to index.linux.sh, since
# I use MacOS and ChromeOS for different purposes.
 
set -e 
source ./devScripts/trap-handler.sh

# TODO SSH Key Gen - May not automate this for MacOS. Thinking on it.
#./configScripts/setup-ssh-keys.sh 

# Note: Will prompt if not installed.
if ! command -v gcc &> /dev/null; then
    xcode-select --install
fi

./configScripts/setup-ssh-keys.sh 

### Everything below this line should require zero prompting from the user ###

# Brew should be installed by bootstrap.sh,
# so we just update the local repo and upgrade packages.
brew update
brew upgrade

# Use GNU Tools
# Inspired by https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
brew install autoconf bash binutils coreutils diffutils ed findutils flex gawk \
    gnu-indent gnu-sed gnu-tar gnu-which gpatch grep gzip less m4 make nano \
    screen watch wdiff wget sd

# Ensure we use GNU stuff as soon as possible.
# Inspired by https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  NEWPATH=${PATH}
  for d in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnubin; do NEWPATH=$d:$NEWPATH; done

  PATH=$(echo "${NEWPATH}" | tr ':' '\n' | cat -n | sort -uk2 | sort -n | cut -f2- | xargs | tr ' ' ':')
  export PATH
fi

# Meant to mirror what is installed in apt-get in index.linux.sh as
# much as possible (and as relevant for my macOS use-cases).
brew install rsync zsh shellcheck imagemagick fd thefuck jq fzf bat htop yq pstree \
    util-linux
brew install --cask gimp vlc

# TODO: the fzf stuff should likely be split off into its own install file to 
# keep mac and chromeos stuff together.
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc

# Meant to mirror the install scripts, though most are handled with brew.
# Debating how to maintain this going forward.

# Replaces ./installScripts/installKitty/index.sh
brew install --cask kitty

# Replaces ./installScripts/install-lsd.sh
brew install lsd

# Replaces ./installScripts/install-lazygit.sh
brew install lazygit

# Replaces ./installScripts/install-lazydocker.sh
brew install lazydocker

# Replaces ./installScripts/install-delta.sh
brew install git-delta

# ./installScripts/install-todo.sh
# ./installScripts/install-hostess.sh
# ./installScripts/install-docker.sh
# ./installScripts/install-theme.sh
# ./installScripts/install-node.sh

./installScripts/installSublime/index.sh
./installScripts/install-fonts.sh
./installScripts/install-zsh.sh
./installScripts/install-yarn-pkgs.sh
./installScripts/install-signal.sh

#### MacOS Specific Software (and stuff I have not added to ChromeOS yet)
brew tap homebrew/cask-drivers
brew install --cask rectangle messenger alt-tab cameracontroller visual-studio-code

# Node-Canvas Deps
brew install pkg-config cairo pango libpng jpeg giflib librsvg

# Note: ChromeOS I just use latest node. May change this later.
brew install asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# User configuration
./configScripts/link-configs.sh