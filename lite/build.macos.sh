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
.beleyenv/brew/bin/brew shellenv
eval "$(.beleyenv/brew/bin/brew shellenv)"

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

### Remove things we explicitly don't want in beleyenv lite ###
# Far from a perfect way. Maybe one day I'll re-think this. 

(
    cd .beleyenv/configs 
    rm -rf systemd dconf deluge dnsmasq.d .gtkrc-2.0 wireplumber solaar etc
)

(
    cd .beleyenv/brew 
    rm -rf .git .github docs Library bin/brew
)

### Verify packages do not have dynamic libs ###
for pkg in "${BREW_PKGS[@]}"; do
    ! type "$pkg" &> /dev/null && echo "$pkg cannot be relocated! Build failed." && exit 1  
done 

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

### Create a release ###
gh release create "beta-$GITHUB_SHA-$GITHUB_RUN_ID" beleyenv-lite-macos.tar.gz
