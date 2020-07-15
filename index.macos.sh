#!/bin/bash 
set -e 

#### Work in progress ####

### bootstrap stuff -- may need to be in separate script?
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# See https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
# To replace everything with gnu tools. Scripts below that
# will depend on this.


brew cask install borgbackup kitty sublime-text docker
brew install lazygit lsd node@12 todo-txt zsh xz nano \
    python@3.7 git jq shellcheck imagemagick thefuck


# TODO - this should be shared!
# Install yarn dependencies
sudo yarn global add eslint prettier

# TODO: write install scripts for/update
# * https://github.com/dandavison/delta#installation
# * Update install-fonts to install to ~/Library/Fonts
# * adjust install-zsh.sh to work on mac
# * Replace python with python installed from cask
# * configuration management.
# * Spectacle is deprecated. Investigate https://github.com/rxhanson/rectangle
# * Backups will have to be done a bit differently