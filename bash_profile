export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export HISTCONTROL=ignoredups

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# for machine-local startup settings, not part of dotfiles
[ -f ~/.local_env ] && source ~/.local_env

source ~/.bashrc
