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
set_custom_ps1() {
  local status=$?  # status of last command; must come first
  local jobs=$(jobs -p)
  local red='\[\e[1;31m\]' # red
  local grn='\[\e[1;32m\]' # green
  local blu='\[\e[1;34m\]' # blue
  local blk='\[\e[1;30m\]' # black
  local wht='\[\e[1;37m\]' # white
  local rst='\[\e[00m\]'   # color reset

  # smiley or unsmiley for status of last command
  [ $status -eq 0 ] && PS1="${grn}:) " || PS1="${red}:( "

  # white current working dir
  PS1+="${wht}\\w "

  # number of stopped/background jobs if any
  [ -n "$jobs" ] && PS1+="[$(echo "$jobs" | grep -c ^)] "

  # red git branch if there are uncommitted changes, green otherwise
  [ -n "$(git status --porcelain 2>/dev/null)" ] && PS1+="$red" || PS1+="$grn"
  PS1+="$(git branch 2>/dev/null | grep ^* | cut -c 3- | sed 's/$/ /')"

  # prompt is '#' for root, '$' for others, and blue if in ssh session
  [ -n "$SSH_CLIENT" ] && PS1+="${blu}" || PS1+="${wht}"; PS1+='\$ '

  # reset the color
  PS1+="$rst"
}

PROMPT_COMMAND="set_custom_ps1"
HISTCONTROL=ignoredups
EDITOR=vim
export EDITOR

# put machine-local stuff in ~/.bashrc.local
[ ! -f ~/.bashrc.local ] || source ~/.bashrc.local
