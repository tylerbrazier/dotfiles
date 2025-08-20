Basic shared dotfiles.
For development use [devfiles](https://github.com/tylerbrazier/devfiles/).

# ~/.bashrc
```
. ~/dotfiles/shrc

bind 'set completion-ignore-case on'

PS1='\w \$ '
```

# ~/.zshrc
```
. ~/dotfiles/shrc

# https://zsh.sourceforge.io/Doc/Release/Completion-System.html
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'

PROMPT='%~ %# '
```

# ~/.vimrc
```
silent! unlet skip_defaults_vim
source $VIMRUNTIME/defaults.vim

source ~/dotfiles/vimrc

set clipboard=unnamed,unnamedplus
```

# ~/.config/nvim/init.lua
```
vim.cmd('source ~/dotfiles/vimrc')

vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.guicursor = 'n-v-c:block,o-r-cr:hor50,i-ci-sm-t:ver25'
```

# ~/.gitconfig
```
[include]
	path = ~/dotfiles/gitconfig
```

# Why not copy dotfiles or use symlinks?

- local changes can still be made without affecting the repo
- track shared settings between vim and neovim,
  but keep what's different between `.vimrc` and `init.lua` local;
  same goes for bash and zsh
- symlinks don't work in Windows

# TODO

- stash save is deprecated
- conditionally set EDITOR and MANPAGER
