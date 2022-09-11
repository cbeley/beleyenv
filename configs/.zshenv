# Most stuff in .zprofile I'd likely want in .zshenv
# instead, but there are some weird things going on:
# 
#  * Kitty, on MacOS, treats every shell as a login shell.
#  * Sublime uses .zprofile to get environment.
#  
#  I may have to re-think this a bit more later.

if [[ $zProfileRan != true ]]; then
    source $HOME/.zprofile
fi