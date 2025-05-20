#!/bin/bash

set -e

# Speed up dock display
defaults write com.apple.dock autohide-time-modifier -float 0.09 && killall Dock

# Disable icons on the desktop
defaults write com.apple.finder CreateDesktop -bool false && killall Finder