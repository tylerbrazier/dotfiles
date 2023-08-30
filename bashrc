# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -h --color=auto'
alias rm='rm -r'
alias cp='cp -r'
alias scp='scp -r'
alias mkdir='mkdir -p'
alias grep='grep --color=auto -i -I'
alias df='df -h'
alias du='du -h -s'

alias x='tar -xzvf'

# Auto ls after cd
cd() { builtin cd "$@" && ls; }

# Prevent ctrl-s from freezing output
stty -ixon

# Add ~/.local/bin to PATH if not already (e.g. from sourcing ~/.bashrc again)
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

export HISTCONTROL=ignoredups
export EDITOR=vim
export MANPAGER='vim -M +MANPAGER -' # :help manpager.vim

# Prompt shows cwd, git branch (red if dirty, green otherwise), stopped jobs,
# and blue $ in ssh session (white otherwise).
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
PS1='\w '
PS1+='\[\e[3$([[ $(git status -s 2>/dev/null) ]] && printf 1 || printf 2)m\]'
PS1+='$(git branch 2>/dev/null | awk "/^*/ {printf \"%s \",substr(\\$0,3)}")'
PS1+='\[\e[39m\]' # reset foreground color
PS1+='$([[ $(jobs) ]] && printf "\j ")'
PS1+='$([ -z "$SSH_CONNECTION" ] || printf "\[\e[34m\]")'
PS1+='\$ '
PS1+='\[\e[39m\]' # reset foreground color

# Use current working dir as the terminal's title:
# https://wiki.archlinux.org/title/Alacritty#%22user@host:cwd%22_in_window_title_bar
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"'

# Save cmds to history when they're run, not just on shell exit
# so history isn't lost when using multiple terminals.
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
