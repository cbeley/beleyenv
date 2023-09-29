#!/bin/bash 

set -e

BREW_PKGS=( "shellcheck" "fd" "jq" "fzf" "yq" "lsd" )

# Create a mock "home directory" and set $HOME to
# that so all scripts install to there for the static build.
mkdir -p "build/.beleyenv/brewInitial"
cd build || exit 1
HOME=$(pwd)
export HOME

### Isolated Homebrew Setup ###

(
    cd .beleyenv
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C brewInitial
)

eval "$(.beleyenv/brewInitial/bin/brew shellenv)"
brew update --force --quiet
brew install "${BREW_PKGS[@]}"

### Re-locate brew to test for pkgs that have a reliance on dynamic libs ###
#
mv .beleyenv/brewInitial .beleyenv/brew 
eval "$(.beleyenv/brew/bin/brew shellenv)"

for pkg in "${BREW_PKGS[@]}"; do
    ! type "$pkg" &> /dev/null && echo "$pkg cannot be relocated! Build failed." && exit 1  
done 

### Set up static home directory dependencies ###
(
    cd ..
    ./installScripts/install-zsh.sh
    ./installScripts/install-fonts.sh    
)

### Copy needed runtime beleyenv dependencies ###
cp -R ../configs ../print.sh .beleyenv
mkdir .beleyenv/configScripts
cp ../configScripts/link-configs.sh .beleyenv/configScripts/
touch .beleyenv/lite

tar -czvf beleyenv-lite-macos.tar.gz .beleyenv .oh-my-zsh Library/Fonts

### Test Result ###
mkdir test
cp beleyenv-lite-macos.tar.gz test/

(
    cd test 
    HOME=$(pwd)
    export HOME
    tar -zxvf beleyenv-lite-macos.tar.gz

    (
        cd .beleyenv
        ./configScripts/link-configs.sh
    )

    ls -la
    ls -la .beleyenv
    ls -la Library
    ls -la Library/Application\ Support
    ls -la Library/Fonts
    ls -la .beleyenv/brew
)

