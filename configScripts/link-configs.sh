#!/bin/bash
set -e

# Kitty Config
mkdir -p ~/.config/kitty
ln -sf "$(pwd)/configs/kitty.conf" ~/.config/kitty/kitty.conf
echo "Kitty config installed!"

# Zsh Configs
ln -sf "$(pwd)/configs/.zshrc" ~/.zshrc
ln -sf "$(pwd)/configs/.p10k.zsh" ~/.p10k.zsh
echo "ZSH configs installed!"

# Todo Config
mkdir -p ~/.todo/
ln -sf "$(pwd)/configs/todo.conf" ~/.todo/config
echo "Todo.sh config installed!"

# Overriden Sommelier Config
ln -sf "$(pwd)/configs/systemd" ~/.config/systemd
echo "systemd local overrides installed!"

echo "All configs installed!"