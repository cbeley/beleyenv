#!/bin/bash
set -e 

EMAIL=$(jq -r '.email' config.json)

ssh-keygen -t rsa -b 4096 -C "$EMAIL" -N '' -f ~/.ssh/id_rsa

# This works in both kitty & the ChromeOS terminal app.  Your milleage may
# vary in other terminals.  It's also a bit problematic, since there seems
# to be no way to reset the buffer.
# [0] https://github.com/tmux/tmux/issues/1477
# [1] https://github.com/tmux/tmux/issues/1477

printf "\033]52;c;$(cat ~/.ssh/id_rsa.pub | base64)\a"

xdg-open https://github.com/settings/ssh/new

echo "Public key copied to clipboard.  Continue to add it on github."