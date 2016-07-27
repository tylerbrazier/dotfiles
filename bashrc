[[ $- != *i* ]] && return  # If not running interactively, don't do anything

#set -o vi  # lets you ESC and use vim commands at bash prompt
stty -ixon  # disable flow control (so ctrl-s doesn't stop the term)
bind 'set completion-ignore-case on'

alias rm='rm -rf'
alias cp='cp -r'
alias scp='scp -r'
alias chown='chown -R'
alias chmod='chmod -R'
alias df='df -h'
alias du='du -h --summarize'
alias htop='htop --delay=5'
alias curl='curl -L'  # follow redirects
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias tma='tmux attach-session'
cd() { builtin cd "$@" && ls; }
untar() { tar -xzf "$1"; }
mktar() { tar -czf "$(basename "$1")".tar.gz "$1"; }

# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
customPS1() {
  sta=$?     # status of last command - must come first
  usr='\u'   # username
  hst='\H'   # hostname
  cwd='\w'   # cwd
  pmt='\\$'  # prompt ('$' for normal user, '#' for root)
  # Colors definitions; ([0 is normal, [1 is bold, [4 is underlined)
  blk='\[\e[1;30m\]' # black
  red='\[\e[1;31m\]' # red
  grn='\[\e[1;32m\]' # green
  ylw='\[\e[1;33m\]' # yellow
  blu='\[\e[1;34m\]' # blue
  pur='\[\e[1;35m\]' # magenta
  cyn='\[\e[1;36m\]' # cyan
  wht='\[\e[1;37m\]' # white
  rst='\[\e[00m\]'   # color reset

  # green smiley for status 0 and red unsmiley otherwise
  [ $sta -eq 0 ] && PS1="${grn}:) " || PS1="${red}:( "

  # red username if root and green otherwise
  [ $(id -u) -eq 0 ] && PS1+="${red}${usr}" || PS1+="${grn}${usr}"

  # white @
  PS1+="${wht}@"

  # cyan hostname if over ssh and white otherwise
  [ "$SSH_CLIENT" == "" ] && PS1+="${wht}${hst} " || PS1+="${cyn}${hst} "

  # white current working dir
  PS1+="${wht}${cwd} "

  # red current git branch
  PS1+="${red}$(git branch 2>/dev/null | grep ^* | cut -c 3- | sed 's/$/ /')"

  # white prompt; '$' if normal user, '#' if root
  PS1+="${wht}${pmt} "

  # reset the color
  PS1+="$rst"
}
PROMPT_COMMAND="customPS1"

ls
