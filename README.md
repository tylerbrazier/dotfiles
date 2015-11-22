dotfiles
========

My home configuration files for linux.

To use these on windows, checkout the `windows` branch.

To install, `git clone --recursive` and run `./setup.sh`.

*WARNING:* `setup.sh` will overwrite any existing dotfiles with links to the
files in this project.

Secret files/dirs like `.ssh` are not in this repo since it's public on github.

If you fork this repo, you'll probably want to change the `name` and `email`
entries in `gitconfig`.
