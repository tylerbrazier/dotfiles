[[ $- != *i* ]] && return  # if not running interactively, don't do anything

stty -ixon  # disable flow control (ctrl-s won't stop the term)
bind 'set completion-ignore-case on'

alias rm='rm -rf'
alias cp='cp -r'
alias scp='scp -r'
alias chown='chown -R'
alias chmod='chmod -R'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h --summarize'
alias curl='curl -L'  # follow redirects
alias grep='grep --color=auto -I'  # ignore binaries
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias s='sudo'
cd() { builtin cd "$@" && ls; }

# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_sequences
set_custom_ps1() {
  local status=$?  # status of last command; must come first
  local jobs=$(jobs -p)
  local red='\[\e[31m\]'
  local grn='\[\e[32m\]'
  local blu='\[\e[1;34m\]'  # bold for better visibility on dark background
  local rst='\[\e[0m\]'  # reset

  # smiley or unsmiley for status of last command
  [ $status -eq 0 ] && PS1="${grn}:) " || PS1="${red}:( "

  # current working dir
  PS1+="${rst}\\w "

  # number of stopped/background jobs if any
  [ -n "$jobs" ] && PS1+="[$(echo "$jobs" | grep -c ^)] "

  # red git branch if there are uncommitted changes, green otherwise
  [ -n "$(git status --porcelain 2>/dev/null)" ] && PS1+="$red" || PS1+="$grn"
  PS1+="$(git branch 2>/dev/null | grep ^* | cut -c 3- | sed 's/$/ /')"

  # prompt is '#' for root, '$' for others, and blue if in ssh session
  [ -n "$SSH_CLIENT" ] && PS1+="$blu" || PS1+="$rst"; PS1+='\$'

  # reset the color
  PS1+="${rst} "
}

PROMPT_COMMAND="set_custom_ps1"
HISTCONTROL=ignoredups
EDITOR=vim
export EDITOR
export MANPAGER

# put machine-local stuff in ~/.bashrc.local
[ ! -f ~/.bashrc.local ] || source ~/.bashrc.local
