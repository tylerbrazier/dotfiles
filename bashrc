# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l -h'
alias la='ls -l -h -a'

alias cp='cp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'

alias grep='grep --color=auto -I'
alias df='df -h'
alias du='du -h'

# auto ls after cd
cd() { builtin cd "$@" && ls; }

# case insensitive completion
bind 'set completion-ignore-case on'

# make history navigation with arrows filter by what's already been typed
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# prevent ctrl-s from freezing output
stty -ixon

# environment variables
export HISTCONTROL=ignoredups
export EDITOR=vim

# Prompt shows stopped jobs (if any) and git status
# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash
source ~/.git-prompt.sh
if [ $? -eq 0 ]; then
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT_PS1_SHOWCOLORHINTS=1
	PROMPT_COMMAND='__git_ps1 "\w" " $([[ $(jobs) ]]&&echo \\j\\040)\\\$ "'
fi
