#/bin/bash

# bail on error
set -e

dotfiles=bash_profile,bashrc,vimrc,gitconfig,tmux.conf

echo "This will OVERWRITE these files in home: $dotfiles"
read -p "Press Enter to continue, ctrl-c to cancel"

curl -L https://raw.githubusercontent.com/tylerbrazier/dotfiles/master/{$dotfiles} -o ~/.#1

# git-prompt.sh is used by bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
