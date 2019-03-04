#/bin/bash

dotfiles=bash_profile,bashrc,vimrc,gitconfig,tmux.conf

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

echo "This will OVERWRITE these files in home: $dotfiles"
read -p "Press Enter to continue, ctrl-c to cancel"

curl -L https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{$dotfiles} -o ~/.#1

# git-prompt.sh is used by bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

read -p "Press Enter to install/update vim plugins, ctrl-c to cancel"

package_dir=~/.vim/pack/x/start
mkdir -p $package_dir

for plugin in ${vim_plugins[@]}; do
	dest=$package_dir/${plugin#*/}
	if [ -d $dest ]; then
		git -C $dest pull
	else
		git clone --depth 1 https://github.com/$plugin $dest
	fi

	# update helptags
	[ -d $dest/doc ] && vim -c "helptags $dest/doc" -c quit
done
