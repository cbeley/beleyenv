#!/bin/bash
set -e

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"

# Share user home with root.
# Inherently insecure.  DO NOT DO THIS FOR MULTI-USER SYSTEMS!
sudo ln -s "$HOME/.oh-my-zsh" /root/.oh-my-zsh
sudo ln -s "$HOME/.zshrc" /root/.zshrc
sudo ln -s "$HOME/.p10k.zsh" /root/.p10k.zsh

sudo chsh -s "$(which zsh)"
sudo chsh -s "$(which zsh)" "${USER}"