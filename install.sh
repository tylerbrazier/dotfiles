#/bin/bash

# bail on error
set -e

dotfiles=bashrc,tmux.conf,gitconfig,vimrc,gvimrc,config/nvim/init.vim,config/nvim/ginit.vim

vim_plugins=(
tpope/vim-sensible
tpope/vim-commentary
tpope/vim-unimpaired
tpope/vim-surround
tpope/vim-repeat
tylerbrazier/vim-bracepair
tylerbrazier/vim-flintstone
ctrlpvim/ctrlp.vim
airblade/vim-gitgutter
pangloss/vim-javascript
editorconfig/editorconfig-vim
gcmt/taboo.vim
)

curl -L --create-dirs https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{$dotfiles} -o ~/.#1

# git-prompt.sh is used by bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

if [ ! -d ~/.tmux-yank ]; then
	git clone --depth 1 https://github.com/tmux-plugins/tmux-yank.git ~/.tmux-yank
	echo "tmux-yank has additional requirements: https://github.com/tmux-plugins/tmux-yank#requirements"
fi

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
