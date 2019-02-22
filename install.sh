#/bin/bash

# bail on error
set -e

dotfiles=bashrc,vimrc,gitconfig,tmux.conf

curl -L https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{$dotfiles} -o ~/.#1
