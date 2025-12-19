__~/.bashrc__

	. ~/dotfiles/shrc

	bind 'set completion-ignore-case on'

	export HISTCONTROL=ignoredups

	PS1='\w$(git branch --color 2>&1 | sed -n "s/^\* \(.*\)/ \1/p") \$ '

__~/.zshrc__

	. ~/dotfiles/shrc

	# make ctrl-a/e/... work
	bindkey -e 

	# https://zsh.sourceforge.io/Doc/Release/Completion-System.html
	autoload -Uz compinit && compinit
	zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'

	setopt HIST_IGNORE_DUPS PROMPT_SUBST

	PROMPT='%~$(git branch --color 2>&1 | sed -n "s/^\* \(.*\)/ \1/p") %# '

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

For development also use [devfiles](https://github.com/tylerbrazier/devfiles/)
