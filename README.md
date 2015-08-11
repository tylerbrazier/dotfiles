dotfiles
========

My home configuration files for linux.

Clone with `git clone --recursive` since this project includes submodules.

To use these on windows, checkout the `windows` branch.

Run `mklinks.sh` to create links from home to each file.
When files are added/removed to/from the repo, remember to update the array
in `mklinks.sh`.

Secret files/dirs like `.ssh` should *not* be in this repo since it's public on
github. There should be a separate private repo for those.

If you fork this repo, you'll probably want to change the `name` and `email`
entries in `.gitconfig`.

.bashrc
-------
- auto `ls` after `cd`
- case insensitive tab completion
- disabled flow control (`ctrl-s` doesn't freeze the terminal)
- colorful prompt with git branch and [un]smiley for previous command status
- colored man pages (in less)
- and aliases, of course

.vimrc
------
- tab complete words
- auto complete brackets, html/xml tags, and other IDE-like features
- line and multiline toggle comment
- code folding (on indent - better than the default implementation)
- autosave while in normal mode
- cut, copy, paste from system clipboard using `ctrl-x`, `ctrl-c`, `ctrl-v`
- statusline with buffer list, file encoding+format, and current git branch
- nice theme
- lots of other useful and practical settings and keybindings
- no plugin dependencies - all of this is defined in the file

.tmux.conf
----------
- all `alt-x` style keybindings (`ctrl-b x` is too much to type)
- bindings for split window, new window, vi-style movement, etc.
- nice theme

.gitconfig
----------
- lots of shortcut aliases (`a = add -A`, `s = status`, etc.)
- include [git-back](https://github.com/tylerbrazier/git-back)
- common command sequence aliases
  - `git up`   - add everything to the index, commit, and push
  - `git down` - stash changes, pull, pop stash, and init/update submodules
  - `git out`  - delete a branch locally and on a remote
