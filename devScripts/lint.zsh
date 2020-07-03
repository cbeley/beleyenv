#!/usr/bin/env zsh
set -e

shellcheck \
	-e SC2002 \
	-e SC2230 \
	-a **/*.sh