#!/usr/bin/env bash
set -e

# Zsh Configs
ln -sf "$(pwd)/configs/.zshrc" ~/.zshrc
ln -sf "$(pwd)/configs/.zprofile" ~/.zprofile
ln -sf "$(pwd)/configs/.zshenv" ~/.zshenv
ln -sf "$(pwd)/configs/.p10k.zsh" ~/.p10k.zsh
./print.sh "ZSH configs installed!"