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
~/dotfiles/scripts/dotfiles.sh -f  #makes symlinks in home to dotfiles
~/dotfiles/scripts/gnome.sh  #if gnome was installed
```

## Termux
After [installing][2], press `Volume Up + q` for extra keys row, then run:
```
# for sdcard access (https://wiki.termux.com/wiki/Termux-setup-storage)
termux-setup-storage

pkg install git
git clone https://github.com/tylerbrazier/dotfiles

cd dotfiles/scripts
./packages.termux.sh
./dotfiles.sh -f
./keygen.sh
```
Pinch to zoom, `Volume Down` for ctrl, long press for copy/paste/help menu.

[1]: https://wiki.archlinux.org/index.php/installation_guide
[2]: https://play.google.com/store/apps/details?id=com.termux&hl=en
