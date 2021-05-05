# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoredups
export EDITOR=vim
export MANPAGER='vim -M +MANPAGER -' # :help manpager.vim

alias ls='ls -h --color=auto'
alias cp='cp -r'
alias rm='rm -r'
alias mkdir='mkdir -p'
alias grep='grep --color=auto -I'
alias df='df -h'
alias du='du -h'

alias x='tar -zxvf'

# auto ls after cd
cd() { builtin cd "$@" && ls; }

# case insensitive completion
bind 'set completion-ignore-case on'

# completion shows suggestions on first Tab press
bind 'set show-all-if-ambiguous on'

# color the completion suggestions
bind 'set colored-stats on'

# make history navigation filter by the text before the cursor
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# prevent ctrl-s from freezing output
stty -ixon

# use current working dir as the terminal's title
# https://wiki.archlinux.org/index.php/Alacritty#%22user@host:cwd%22_in_Window_Title_Bar
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"'

# prompt shows cwd, git branch (red if dirty, green otherwise), and stopped jobs
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
PS1='\w '
PS1+='\[$([[ $(git status -s 2>/dev/null) ]] && tput setaf 1 || tput setaf 2)\]'
PS1+='$(git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/^* \(.*\)/\1 /")'
PS1+='\[$(tput sgr0)\]'
PS1+='$([[ $(jobs) ]] && printf "\j ")'
PS1+='\$ '
