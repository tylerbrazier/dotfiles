# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export HISTCONTROL=ignoredups

# auto ls after cd
cd() { builtin cd "$@" && ls --color=auto; }

alias ls='ls --color=auto'
alias ll='ls -l -h'
alias la='ls -l -h -A'

alias cp='cp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'

alias grep='grep --color=auto -I'
alias df='df -h'
alias du='du -h'

alias x='tar -zxvf'
alias s='sudo '

# tab-complete command names after s alias (sudo)
complete -c s

# case insensitive completion
bind 'set completion-ignore-case on'

# completion shows suggestions on first Tab press
bind 'set show-all-if-ambiguous on'

# color the completion suggestions
bind 'set colored-stats on'

# make history navigation with arrows filter by what's already been typed
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# prevent ctrl-s from freezing output
stty -ixon

# prompt shows cwd, git branch (red if dirty, green otherwise), and stopped jobs
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
PS1='\w '
PS1+='\[$([[ $(git status -s 2>/dev/null) ]] && tput setaf 1 || tput setaf 2)\]'
PS1+='$(git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/^* \(.*\)/\1 /")'
PS1+='\[$(tput sgr0)\]'
PS1+='$([[ $(jobs) ]] && printf "\j ")'
PS1+='\$ '
