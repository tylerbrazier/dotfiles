	git clone git@github.com:tylerbrazier/dotfiles ~/src/dotfiles

__~/.bashrc__

	. ~/src/dotfiles/shrc

	bind 'set completion-ignore-case on'

	# ctrl-p/n filter by what's already been typed
	bind '"\C-p": history-search-backward'
	bind '"\C-n": history-search-forward'

	export HISTCONTROL=ignoredups
	export CDPATH="$HOME/src"

	PS1='\w$(git branch --color 2>&1 | sed -n "s/^\* \(.*\)/ \1/p") \$ '

__~/.zshrc__

	. ~/src/dotfiles/shrc

	# make ctrl-a/e/... work
	bindkey -e 

	export CDPATH="$HOME/src"

	# https://zsh.sourceforge.io/Doc/Release/Completion-System.html
	autoload -Uz compinit && compinit
	zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'

	setopt HIST_IGNORE_DUPS PROMPT_SUBST

	PROMPT='%~$(git branch --color 2>&1 | sed -n "s/^\* \(.*\)/ \1/p") %# '

__~/.vimrc__

	silent! unlet skip_defaults_vim
	source $VIMRUNTIME/defaults.vim

	source ~/src/dotfiles/vimrc

	set clipboard=unnamed,unnamedplus

__~/.config/nvim/init.lua__

	vim.cmd('source ~/src/dotfiles/vimrc')
	vim.cmd('source ~/src/dotfiles/plugs.lua')

	vim.o.clipboard = 'unnamed,unnamedplus'
	vim.o.guicursor = 'n-v-c:block,o-r-cr:hor50,i-ci-sm-t:ver25'

__~/.gitconfig__

	[include]
		path = ~/src/dotfiles/gitconfig
