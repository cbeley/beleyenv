# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#############################################################
################# Exported Enviornment ######################
#############################################################

# ChromeOS Specific Stuff
if [[ $OSTYPE != 'darwin'* ]]; then
  # This is very bad in multi-user enviornments.  Do not set this to true there.
  # However, in the crostini container, root is only accessible via the 
  # user and has no password.  If someone compromises your user account, they
  # have compromised your root account.  Setting this to true lets us do fun things
  # like share the same checked in zsh configs with both the normal user and root.
  export ZSH_DISABLE_COMPFIX="true"

  # Crostini only mounts the home directory, so anything
  # that uses xdg-open with temp files will not work unless
  # we change the default temp directory to be within home.
  # TODO: temp directory rotation.
  mkdir -p $HOME/.tmp
  export TMPDIR=$HOME/.tmp

  source ~/.beleyenv/borg-env.export

  # Explicitly setting so root shells work properly with kitty.
  # Doing this on MacOS may have other pitfalls
  # Look into https://sw.kovidgoyal.net/kitty/faq/ if it becomes relevant later.
  export TERMINFO="/usr/local/beleyenv/kitty.app/lib/kitty/terminfo"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#############################################################
############### oh-my-zsh & p10k configuration ##############
#############################################################

######
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

plugins=(git colored-man-pages colorize extract web-search docker node yarn asdf)

source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh

#############################################################
######################## Aliases ############################
#############################################################
#
# The brew installed fd used fd. debian uses fdfind.
if ! (which fd >& /dev/null); then
  alias fd="fdfind"
fi

# Debian aliases bat to batcat. In this case, add an alis.
if (which batcat >& /dev/null;) then
  alias bat="batcat"
fi

alias sm="smerge ."
alias ls="lsd"
alias icat="kitty +kitten icat"

# ChromeOS Specific Stuff
if [[ $OSTYPE != 'darwin'* ]]; then
  alias mountBackups="sudo mkdir -p /mnt/borgBackups && \
      sudo chmod o+rw /mnt/borgBackups && \
      borg mount :: /mnt/borgBackups && \
      cd /mnt/borgBackups"

  alias umountBackups="cd && borg umount /mnt/borgBackups && sudo rm -rf /mnt/borgBackups"
fi

#############################################################
########################## Misc #############################
#############################################################

eval $(thefuck --alias)

[ -f $HOME/.zsh-work ] && source $HOME/.zsh-work
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ $OSTYPE != 'darwin'* ]]; then
  # TODO: Combine this with what's going on with the macOS 
  # install script later. See Line 108.
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# Just base auto completion for things like `git add` based on
# the filesystem. Better experience for large repos.
__git_files () { 
    _wanted files expl 'local files' _files     
}
