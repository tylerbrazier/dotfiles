# ~/.bashrc

[[ $- != *i* ]] && return   # If not running interactively, don't do anything

### Editing options
#set -o vi           # lets you ESC and use vim commands at bash prompt
stty stop undef      # ctrl-s doesn't freeze term
stty start undef     # ctrl-q doesn't unfreeze term

### Environment Variables
export HISTCONTROL=ignoredups   # no duplicate entries in bash history
type vim 1>/dev/null 2>&1 && export EDITOR=vim || export EDITOR=vi
type vimpager 1>/dev/null 2>&1 && export PAGER=vimpager || export PAGER=less

### Aliases
alias cp='cp -r'
alias grep='grep --color=auto'
alias ls='ls -b -F --color=auto' # -b is show escape chars. -F is indicators
alias ll='ls -lh'
alias la='ls -alh'
alias df='df -h'
alias du='du -h --summarize'
alias htop='htop --delay=5'
alias pingg='ping google.com'
alias ping8='ping 8.8.8.8'
alias pacautoremove='sudo pacman -Rns $(pacman -Qdtq)'
alias yogurt='yaourt --noconfirm'
alias mntsdb1='sudo mount /dev/sdb1 /mnt'
alias umntsdb1='sudo umount /mnt'

# ls after cd
cd() { [[ -d "$1" ]] && { builtin cd "$1" && ls; } || { builtin cd ~ && ls; } }

# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
set_prompt() {
  sta=$?             # status of last command - must come first
  usr='\u'           # username
  hst='\h'           # hostname up to first '.'; capital H for full hostname
  cwd='\w'           # current working dir; capital W for just base name
  pmt='\\$'          # prompt - will be '$' if normal user, '#' if root
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
  [[ $sta == 0 ]] && PS1="${grn}:) " || PS1="${red}:( "

  # red username if root and green otherwise
  [[ $(id -u) == 0 ]] && PS1+="${red}${usr}" || PS1+="${grn}${usr}"

  # white @
  PS1+="${wht}@"

  # cyan hostname if over ssh and white otherwise
  [[ $SSH_CLIENT == "" ]] && PS1+="${wht}${hst} " || PS1+="${cyn}${hst} "

  # current working dir
  PS1+="${wht}${cwd} "

  # current git branch
  PS1+="$(git branch 2>/dev/null | grep ^* | sed 's/\* /(/g' | sed 's/$/) /g')"

  # white prompt; '$' if normal user, '#' if root
  PS1+="${wht}${pmt} "

  # reset the color
  PS1+="$rst"
}
PROMPT_COMMAND='set_prompt'

ls
