# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#############################################################
################# Exported Enviornment ######################
#############################################################

# Explicitly setting so root shells work properly with kitty.
export TERMINFO="/usr/local/opt/kitty.app/lib/kitty/terminfo"

# This is very bad in multi-user enviornments.  Do not set this to true there.
# However, in the crostini container, root is only accessible via the 
# user and has no password.  If someone compromises your user account, they
# have compromised your root account.  Setting this to true lets us do fun things
# like share the same checked in zsh configs with both the normal user and root.
export ZSH_DISABLE_COMPFIX="true"

# Path to oh-my-zsh installation.
export ZSH="/home/cbeley/.oh-my-zsh"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='subl'
fi

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

plugins=(git colored-man-pages colorize extract web-search docker node)

source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh

#############################################################
######################## Aliases ############################
#############################################################
alias ls="lsd"

eval $(thefuck --alias)