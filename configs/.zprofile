if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  # -n opens a new window
  # -w tells sublime to wait for the file to be saved before returning.
  export EDITOR='subl -n -w'
fi

# Want everything below this to override this.
if [[ -f /opt/twitter_mde/etc/zshrc ]]; then
  source /opt/twitter_mde/etc/zshrc
fi

# Enable Homebrew and use GNU for everything.
if type "/opt/homebrew/bin/brew" &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Inspired by https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  NEWPATH=${PATH}
 
  for d in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnubin; do 
    # Only libtool causes issues with asdf installation of new node versions.
    # Some other things may be problematic for me in the future. I'll re-think 
    # this later as needed.
    if [[ $d != *"libtool"* ]]; then
      NEWPATH=$d:$NEWPATH;
    fi
  done

  for d in "${HOMEBREW_PREFIX}"/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done

  PATH=$(echo "${NEWPATH}" | tr ':' '\n' | cat -n | sort -uk2 | sort -n | cut -f2- | xargs | tr ' ' ':')
  
  export PATH

  # Annoyingly, some scripts are still expecting 'python' instead of 'python3'.
  path=($HOMEBREW_PREFIX/opt/python@3.9/libexec/bin $path)

  # Ensure util-linux packages are in path (from homebrew)
  path=(/opt/homebrew/opt/util-linux/bin /opt/homebrew/opt/util-linux/sbin $path)
fi

# Ensure local path considered first for my own installed
# global packages.
path=($HOME/bin $HOME/.local/bin $HOME/.beleyenv/brew/bin $(yarn global bin) $path)

export PATH

# For one-off cases where I want to have custom shell completions.
fpath=($HOME/.custom-completions $HOME/.beleyenv/brew/share/zsh/site-functions $fpath)

# See .zshenv
zProfileRan=true
export zProfileRan