#!/bin/bash

# bail on error
set -e

echo '
bashrc
gitconfig
vimrc
' | xargs -I {} curl https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{} -o ~/.{}

# :help packages
mkdir -p ~/.vim/pack/x/start
cd ~/.vim/pack/x/start
echo '
tpope/vim-commentary
tpope/vim-surround
tpope/vim-repeat
tylerbrazier/vim-flintstone
airblade/vim-gitgutter
pangloss/vim-javascript
editorconfig/editorconfig-vim
' | xargs -I {} git clone --depth 1 https://github.com/{}

# To update the plugins:
#   ls -d ~/.vim/pack/x/start/* | xargs -I {} git -C {} pull
