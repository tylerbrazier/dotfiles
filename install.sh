#/bin/bash

# bail on error
set -e

dotfiles=bashrc,vimrc,gitconfig,tmux.conf

vim_plugins=(
tpope/vim-sensible
tpope/vim-commentary
tpope/vim-unimpaired
tpope/vim-surround
tpope/vim-repeat
ctrlpvim/ctrlp.vim
jiangmiao/auto-pairs
airblade/vim-gitgutter
pangloss/vim-javascript
editorconfig/editorconfig-vim
gcmt/taboo.vim
)

curl -L https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{$dotfiles} -o ~/.#1

# git-prompt.sh is used by bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

# :help packages
package_dir=~/.vim/pack/x/start
mkdir -p $package_dir

for plugin in ${vim_plugins[@]}; do
	dest=$package_dir/${plugin#*/}
	if [ -d $dest ]; then
		git -C $dest pull
	else
		git clone --depth 1 https://github.com/$plugin $dest
	fi
done
echo "Run ':helptags ALL' in vim to regenerate helptags (may require sudo)"
