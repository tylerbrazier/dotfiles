#/bin/bash

# bail on error
set -e

dotfiles=bashrc,bash_profile,tmux.conf,gitconfig,vimrc

vim_plugins=(
tpope/vim-commentary
tpope/vim-surround
tpope/vim-repeat
tylerbrazier/vim-flintstone
airblade/vim-gitgutter
pangloss/vim-javascript
editorconfig/editorconfig-vim
gcmt/taboo.vim
)

curl -L --create-dirs https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{$dotfiles} -o ~/.#1

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
