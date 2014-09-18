# ~/.bash_profile

source ~/.bashrc

PATH+=":${HOME}/bin"
export PATH

type keychain 1>/dev/null 2>&1 &&  # if keychain can be executed
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)

[[ -x ${HOME}/.xinitrc ]] &&  # if ~/.xinitrc is executable
[[ -z $DISPLAY ]]         &&  # and we're not already in a gui
[[ $XDG_VTNR -eq 1 ]]     &&  # and we're on virtual terminal 1
exec startx                   # then start X
