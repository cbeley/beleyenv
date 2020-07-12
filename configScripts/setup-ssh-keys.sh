#!/bin/bash
set -e 

EMAIL=$(jq -r '.email' config.json)

# Keygen returns exit one if the user says not to overwrite their
# existing keys.  Since all scripts in this repo should be idempotent
# and because there are legitimate reasons not to overwrite the key
# files, we just skip SSH key config in this case.
set +e

ssh-keygen -t rsa -b 4096 -C "$EMAIL" -N '' -f ~/.ssh/id_rsa

keygenExitCode=$?

set -e

if [[ $keygenExitCode != 0 ]]; then
	./print.sh "Assuming you entered 'No' when asked to ovewrite keys\n\
Skipping SSH key-gen generation..."
	notify-send -a 'beleyenv' '[WARN] SSH key-gen canceled' \
		'If you did not answer no to overwrite keys, something may have gone wrong.'

	exit 0
fi

# This works in both kitty & the ChromeOS terminal app.  Your milleage may
# vary in other terminals.  It's also a bit problematic, since there seems
# to be no way to reset the buffer.
# [0] https://github.com/tmux/tmux/issues/1477
# [1] https://github.com/tmux/tmux/issues/1477

printf "\033]52;c;%s\a" "$(cat ~/.ssh/id_rsa.pub | base64)"

# The above does not tend to work, so also print it to the terminal to copy.
./print.sh "If it was not auto-copied, copy your key here and paste it into github."
cat ~/.ssh/id_rsa.pub

xdg-open https://github.com/settings/ssh/new

./print.sh "Public key copied to clipboard.  Continue to add it on github."
