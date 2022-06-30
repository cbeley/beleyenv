if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='subl'
fi

# Want everything below this to override this.
if [[ -f /opt/twitter_mde/etc/zshrc ]]; then
  source /opt/twitter_mde/etc/zshrc
fi

# Enable Homebrew and use GNU for everything.
if [[ $OSTYPE == 'darwin'* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Inspired by https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  NEWPATH=${PATH}
 
  for d in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnubin; do NEWPATH=$d:$NEWPATH; done
  for d in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done

  PATH=$(echo "${NEWPATH}" | tr ':' '\n' | cat -n | sort -uk2 | sort -n | cut -f2- | xargs | tr ' ' ':')
  export PATH
fi

# Ensure local path considered first for my own installed
# global packages.
path=($HOME/bin $(yarn global bin) $path)

export PATH

# For one-off cases where I want to have custom shell completions.
fpath=($HOME/.custom-completions $fpath)