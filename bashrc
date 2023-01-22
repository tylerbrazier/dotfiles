# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -h --color=auto'
alias cp='cp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'
alias grep='grep --color=auto -I'
alias df='df -h'
alias du='du -h'

alias x='tar -xzvf'

# auto ls after cd
cd() { builtin cd "$@" && ls; }

# case insensitive completion
bind 'set completion-ignore-case on'

# completion shows suggestions on first Tab press
bind 'set show-all-if-ambiguous on'

# color the completion suggestions
bind 'set colored-stats on'

# make history navigation with arrows filter by the text before the cursor
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# prevent ctrl-s from freezing output
stty -ixon

[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

export HISTCONTROL=ignoredups
export EDITOR=vim
export MANPAGER='vim -M +MANPAGER -' # :help manpager.vim

# Prompt shows cwd, git branch (red if dirty, green otherwise), stopped jobs,
# and blue $ in ssh session (white otherwise).
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
PS1='\w '
PS1+='\[$([[ $(git status -s 2>/dev/null) ]] && tput setaf 1 || tput setaf 2)\]'
PS1+='$(git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/^* \(.*\)/\1 /")'
PS1+='\[$(tput sgr0)\]'
PS1+='$([[ $(jobs) ]] && printf "\j ")'
PS1+='\[$([ -z "$SSH_CONNECTION" ] || tput setaf 4)\]'
PS1+='\$'
PS1+='\[$(tput sgr0)\] '

# Use current working dir as the terminal's title:
# https://wiki.archlinux.org/title/Alacritty#%22user@host:cwd%22_in_window_title_bar
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"'

# Save cmds to history when they're run, not just on shell exit
# so history isn't lost when using multiple terminals.
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
