#!/usr/bin/env bash

set -e

# Speed up dock display
defaults write com.apple.dock autohide-time-modifier -float 0.09 && killall Dock

# Debating whether I like this or not, so commenting out,
# but keeping it here for future reference. This has the extra consequences
# of being unable to do things like click the desktop to hide windows
# and right click the desktop. 
# Disable icons on the desktop
# defaults write com.apple.finder CreateDesktop -bool true && killall Finder