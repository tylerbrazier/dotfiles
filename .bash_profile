# ~/.bash_profile

PATH+=":${HOME}/bin"
export PATH

#eval $(keychain --eval --agents ssh -Q --quiet id_rsa)  # add ssh key

[[ -x ${HOME}/.xinitrc ]] &&  # if ~/.xinitrc is executable
[[ -z $DISPLAY ]]         &&  # and we're not already in a gui
[[ $XDG_VTNR -eq 1 ]]     &&  # and we're on virtual terminal 1
exec startx                   # then start X

source ~/.bashrc
