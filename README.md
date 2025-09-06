Basic dotfiles.
For development also use [devfiles](https://github.com/tylerbrazier/devfiles/)

__~/.bashrc__

	. ~/dotfiles/shrc

	bind 'set completion-ignore-case on'

	export HISTCONTROL=ignoredups

	PS1='\w \$ '

__~/.zshrc__

	. ~/dotfiles/shrc

	# https://zsh.sourceforge.io/Doc/Release/Completion-System.html
	autoload -Uz compinit && compinit
	zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'

	setopt HIST_IGNORE_DUPS

	PROMPT='%~ %# '

__~/.vimrc__

	silent! unlet skip_defaults_vim
	source $VIMRUNTIME/defaults.vim

	source ~/dotfiles/vimrc

	set clipboard=unnamed,unnamedplus

__~/.config/nvim/init.lua__

	vim.cmd('source ~/dotfiles/vimrc')

	vim.o.clipboard = 'unnamed,unnamedplus'
	vim.o.guicursor = 'n-v-c:block,o-r-cr:hor50,i-ci-sm-t:ver25'

__~/.gitconfig__

	[include]
		path = ~/dotfiles/gitconfig

__Why not copy dotfiles or use symlinks?__

- local changes can still be made without affecting the repo
- track shared settings between vim and neovim,
  but keep what's different between `.vimrc` and `init.lua` local;
  same goes for bash and zsh
- symlinks don't work in Windows

__TODO__

- stash save is deprecated
- conditionally set EDITOR and MANPAGER
