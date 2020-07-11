#!/usr/bin/env zsh
set -e

# Note SC1117 was retired after v0.5, but debian package is 
# old.  Remove exception when the package gets updated.
#
shellcheck \
	-e SC2002 \
	-e SC2230 \
    -e SC1117 \
	-a **/*.sh