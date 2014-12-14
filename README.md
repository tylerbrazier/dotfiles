dotfiles
========

My home configuration files for linux.

Run `mklinks.sh` to create links from home to each dotfile.

Secret files/dirs like .ssh should not be in this repo since it's public on
github. There should be a separate private repo for those.

Experimental changes should be made on the `dev` branch and can be pushed for
backup/sync using `git up` (alias defined in .gitconfig).
Use `git merge --squash` when merging `dev` into `master` so the log isn't full
of a bunch of empty, experimental commits. `master` should have a clean log.
