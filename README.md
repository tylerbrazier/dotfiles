dotfiles
========

My home configuration files for linux.

Run `mklinks.sh` to create links from home to each dotfile.

Secret files/dirs like `.ssh` should *not* be in this repo since it's public on
github. There should be a separate private repo for those.

Experimental changes should be made on feature branches and can be pushed for
backup/sync using `git up` (alias defined in .gitconfig).
Use `git merge --squash` when merging a feature branch into `master` so that
`master` retains a clean log.

If you fork this repo, you'll probably want to change the `name` and `email`
entries in `.gitconfig`.


.vimrc
------
**Features**

* tab completion
* line and multiline toggle comment
* better indent code folding
* convert file: to utf-8, unix line ends, tabs to spaces, trim whitespace
* statusline with buffer list and current git branch
* other useful and practical settings and keybindings

**Custom keybindings** (`c-x` means `ctrl + x`)

Binding   | What it does
----------|----------------------------------------
Enter     | faster way to enter vim commands (:)
!         | faster way to run shell commands (:!)
q         | :q instead of recording
Y         | capital Y behaves like capital C and D (y$)
c-n       | [n]ext buffer
c-p       | [p]revious buffer
c-d       | [d]elete current buffer
c-q       | [q]uit
c-w       | move to next [w]indow
c-t       | toggle using [t]abs or spaces for tab key
c-h       | toggle showing [h]ighlighted stuff
c-s       | toggle [s]pell check
c-f       | [f]ix misspelled word under cursor
c-c       | [c]onvert file to uft8, unix line ending, tabs to spaces, trim ws
c-u       | toggle showing line n[u]mbers
c-/, c-o  | toggle c[o]mment on line or visual selection
c-l       | toggle code fo[l]d
c-a       | emacs-style go to st[a]rt of line
c-e       | emacs-style go to [e]nd of line

Note: `c-/` for toggle comment works on some terminals but not in Gvim :(
If it doesn't work, just use `c-o` instead.

In visual mode, `c-c` and `c-x` work like the standard copy and cut bindings.
In insert mode, `c-v` and `c-z` work like the standard paste and undo bindings.

In insert mode, `tab` can be used for word completion if the cursor is
proceeded by a non-whitespace character.


.tmux.conf
----------
**Custom keybindings** (`a-x` means `alt + x` or `meta + x`)

Binding | What it does
--------|----------------------------
a-\     | split window vertically
a--     | split window horizontally
a-h     | vim-style move to left pane
a-j     | vim-style move to left down
a-k     | vim-style move to left up
a-l     | vim-style move to left right
a-n     | move to next window
a-p     | move to previous window
a-t     | create new window
a-d     | kill current pane
a-q     | kill current window
a-c     | go into copy mode (so you can scroll)

