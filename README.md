# ~/.bashrc

    . ~/dotfiles/shrc

    PS1='\w \$ '

# ~/.zshrc

    . ~/dotfiles/shrc

    # https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
    # https://gist.github.com/chrisnolet/d3582cd63eb3d7b4fcb4d5975fd91d04
    autoload -Uz compinit vcs_info
    compinit # completion
    # Don't bother using check-for-changes to set %c and %u
    # since a hook is needed for checking untracked files anyways.
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' formats '%F{green}%b%f '
    zstyle ':vcs_info:git:*' actionformats '%F{green}%b (%a)%f '
    zstyle ':vcs_info:git+set-message:*' hooks git_status
    +vi-git_status() {
    	if [ -n "$(git status -s 2>/dev/null)" ]; then
    		hook_com[branch]="%F{red}${hook_com[branch]}"
    	fi
    }
    precmd () { vcs_info }
    setopt PROMPT_SUBST
    PS1='%~ ${vcs_info_msg_0_}%# '

# ~/.vimrc

    silent! unlet skip_defaults_vim
    source $VIMRUNTIME/defaults.vim

    source ~/dotfiles/vimrc

    set clipboard=unnamed,unnamedplus

# ~/.config/nvim/init.lua

    vim.cmd('source ~/dotfiles/vimrc')

    vim.o.clipboard = 'unnamed,unnamedplus'
    vim.o.guicursor = 'n-v-c:block,o-r-cr:hor50,i-ci-sm-t:ver25'

# ~/.gitconfig

    [include]
    	path = ~/dotfiles/gitconfig

# Why not copy dotfiles or use symlinks?

- local changes can still be made without affecting the repo
- track shared settings between vim and neovim,
  but keep what's different between `.vimrc` and `init.lua` local;
  same goes for bash and zsh
- symlinks don't work in Windows
