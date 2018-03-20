# dotfiles
Personal configuration files and scripts

## Arch linux
What to run after a fresh [installation][1]:
```
systemctl start dhcpcd  #start wired internet
pacman -Sy git sudo
git clone https://github.com/tylerbrazier/dotfiles

cd dotfiles/scripts
./packages.arch.sh  #install packages
./services.sh       #enable services
./superuseradd.sh   #add a user who can sudo

su <new user>
./keygen.sh  #generate ssh key pair
git clone git@github.com:tylerbrazier/dotfiles ~/dotfiles
~/dotfiles/scripts/dotfiles.sh -f -g  #makes symlinks in home to dotfiles
```

[1]: https://wiki.archlinux.org/index.php/installation_guide
