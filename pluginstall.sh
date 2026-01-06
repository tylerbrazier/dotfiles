#!/bin/sh

# This can likely be replaced by vim.pack when neovim 0.12 is stable
# https://neovim.io/doc/user/pack.html#vim.pack

pack_dir="$HOME/.config/nvim/pack/brazier/start"
plugin_urls='
git@github.com:tylerbrazier/vim-forgit.git
git@github.com:tylerbrazier/vim-marcos.git
git@github.com:tylerbrazier/vim-gh.git
git@github.com:tylerbrazier/vim-cd.git
git@github.com:tylerbrazier/vim-gc.git
git@github.com:tylerbrazier/vim-flintstone.git
https://github.com/neovim/nvim-lspconfig.git
https://github.com/lewis6991/gitsigns.nvim.git
'

set -x

mkdir -p "$pack_dir"
cd "$pack_dir" || exit

echo "$plugin_urls" | xargs -t -L 1 git clone

nvim --headless -u NORC -c 'helptags ALL' -c q

sudo npm install -g typescript typescript-language-server
