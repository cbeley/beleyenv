#!/bin/bash

set -e

defaults write com.apple.dock autohide-time-modifier -float 0.09; killall Dock