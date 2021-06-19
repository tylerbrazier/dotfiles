#!/bin/bash

# bail on error
set -e

cd ~
pwd
echo '
bashrc
gitconfig
vimrc
' | xargs -t -I {} curl -s https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{} -o .{}

# :help packages
mkdir -p ~/.vim/pack/x/start
cd ~/.vim/pack/x/start
pwd
echo '
tpope/vim-commentary
tpope/vim-surround
tpope/vim-repeat
tylerbrazier/vim-flintstone
airblade/vim-gitgutter
pangloss/vim-javascript
editorconfig/editorconfig-vim
' | xargs -t -I {} git clone -q --depth 1 https://github.com/{}

# To update the plugins:
#   ls -d ~/.vim/pack/x/start/* | xargs -I {} git -C {} pull
