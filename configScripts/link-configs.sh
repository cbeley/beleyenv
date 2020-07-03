#!/bin/bash
set -e

# Kitty Config
mkdir -p ~/.config/kitty
cp configs/kitty.conf ~/.config/kitty/
echo "Kitty config installed!"

# Todo Config
mkdir -p ~/.todo/
cp configs/todo.conf ~/.todo/config
echo "Todo.sh config installed!"

echo "All configs installed!"