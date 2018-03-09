# dotfiles

- `scripts/dotfiles.sh [-f] [-p] [-g] [-r]` makes symlinks in home to dotfiles
  - `-f` to overwrite existing files in home
  - `-p` to also install vim plugins
  - `-g` to include config files for gui
  - `-r` to include retroarch stuff and download roms
- `scripts/keygen.sh` generates ssh keys
- `scripts/packages.*.sh` installs packages
- `scripts/superuseradd.sh` adds a new user who can sudo
- `scripts/autologin.sh <user>` automatically login as `<user>` on boot
