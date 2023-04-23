#!/bin/bash
set -e

rm -rf ~/.oh-my-zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
    --unattended --keep-zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

if grep -q 'ID=debian' /etc/os-release; then
    # Share user home with root.
    # Inherently insecure.  DO NOT DO THIS FOR MULTI-USER SYSTEMS!
    # Currently I only use ChromeOS or MacOS, but if I adapt this to
    # Linux directly, this will have to be adjusted further.
    
    sudo ln -sf "$HOME/.oh-my-zsh" /root/.oh-my-zsh
    sudo ln -sf "$HOME/.zshrc" /root/.zshrc
    sudo ln -sf "$HOME/.p10k.zsh" /root/.p10k.zsh
fi

sudo chsh -s "$(which zsh)"
sudo chsh -s "$(which zsh)" "${USER}"

./print.sh "zsh tooling installed!"