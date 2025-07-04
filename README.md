# Shell

In `~/.bashrc` or `~/.zshrc`:

    . ~/dotfiles/shrc

## Git status in prompt

    curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh

for bash also get the completion file:

    curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-completion.bash

in `~/.bashrc`:

    . ~/.git-completion.bash
    . ~/.git-prompt.sh
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    PROMPT_COMMAND='__git_ps1 "\w " "\$ " "%s "'

<https://git-scm.com/book/en/v2/Appendix-A:-Git-in-Other-Environments-Git-in-Bash>

in `~/.zshrc`:

    autoload -Uz compinit && compinit
    . ~/.git-prompt.sh
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    precmd() { __git_ps1 '%~ ' '%# ' '%s ' }

<https://git-scm.com/book/en/v2/Appendix-A:-Git-in-Other-Environments-Git-in-Zsh>

# (Neo)Vim

In `~/.vimrc`:

    silent! unlet skip_defaults_vim
    source $VIMRUNTIME/defaults.vim

    source ~/dotfiles/vimrc

    set clipboard=unnamed,unnamedplus

In `~/.config/nvim/init.lua`:

    vim.cmd('source ~/dotfiles/vimrc')

    vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

# Git

In `~/.gitconfig`:

    [include]
    	path = ~/dotfiles/gitconfig

# Why not copy dotfiles or use symlinks?

- local changes can still be made without affecting the repo
- track shared settings between vim and neovim,
  but keep what's different between `.vimrc` and `init.lua` local;
  same goes for bash and zsh
- symlinks don't work in Windows
