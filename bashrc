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
cd() { builtin cd "$@" && ls; }

# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
customPS1() {
  status=$?  # status of last command; must come first
  red='\[\e[1;31m\]' # red
  grn='\[\e[1;32m\]' # green
  blu='\[\e[1;34m\]' # blue
  blk='\[\e[1;30m\]' # black
  wht='\[\e[1;37m\]' # white
  rst='\[\e[00m\]'   # color reset

  # smiley or unsmiley for status of last command
  [ $status -eq 0 ] && PS1="${grn}:) " || PS1="${red}:( "

  # white current working dir
  PS1+="${wht}\\w "

  # red current git branch
  PS1+="${red}$(git branch 2>/dev/null | grep ^* | cut -c 3- | sed 's/$/ /')"

  # blue prompt if over ssh and white otherwise; '#' for root, '$' for others
  [ "$SSH_CLIENT" == "" ] && PS1+="${wht}\\\$ " || PS1+="${blu}\\\$ "

  # reset the color
  PS1+="$rst"
}
PROMPT_COMMAND="customPS1"

ls
