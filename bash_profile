# ~/.bash_profile

PATH=${PATH}:~/bin
export HISTCONTROL=ignoredups       # no duplicate entries in bash history
type vim >/dev/null 2>&1 && export EDITOR=vim || export EDITOR=vi
type vimpager >/dev/null 2>&1 && export PAGER=vimpager || export PAGER=less

source ~/.bashrc