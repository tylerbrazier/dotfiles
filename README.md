dotfiles
========

My home configuration files for linux.

To use these on windows, checkout the `windows` branch.

Run `mklinks.sh` to create links from home to each dotfile.
When files are added/removed to/from the repo, remember to update the array
in `mklinks.sh`.

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
* code folding (on indent - better than default implementation)
* convert file: to utf-8, unix line ends, tabs to spaces, trim whitespace
* statusline with buffer list and current git branch
* autosave (while in normal mode)
* other useful and practical settings and keybindings

**Custom keybindings** (`c-x` means `ctrl + x`)

Binding   | What it does
----------|----------------------------------------
[Enter]   | faster way to enter vim commands (:)
!         | faster way to run shell commands (:!)
!!        | repeat previous shell command (:!!)
!!!       | execute current file (:!%:p)
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
c-x       | edit scratch file `/tmp/scratch`

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
a-\     | split pane vertically
a--     | split pane horizontally
a-h     | vim-style move to left pane
a-j     | vim-style move to left down
a-k     | vim-style move to left up
a-l     | vim-style move to left right
a-d     | kill current pane
a-t     | create new window
a-n     | move to next window
a-p     | move to previous window
a-r     | rename current window
a-q     | kill current window
a-c     | go into copy mode (so you can scroll)


.gitconfig
----------
**Aliases** (with definitions below each)

    git up [args for push]

Add everything to the index, commit, and push.
Additional arguments given will be passed onto `git push`.
This is a fast alternative to typing the common sequence of commands.

    git down [args for pull]

Stash everything (including untracked files), pull, and pop stash.
Additional arguments given will be passed onto `git pull`.
This is a quick way to update your local branch.

    git ready [<remote>] <branch>

If `<remote>` isn't given, it defaults to `origin`.
If `<branch>` exists on `<remote>`, check it out.
If it doesn't, create the branch and push it to `<remote>`.
In either case, the local `<branch>` will track `<remote>/<branch>`.
This is useful when starting a new feature branch or grabbing one that was
started on another machine.

    git out [<remote>] <branch>

If `<remote>` isn't given, it defaults to `origin`.
Delete `<branch>` locally and on `<remote>`.
Useful for cleaning up temporary feature branches.

Some other shortcuts for common commands:

Alias | What it does
------|------------------
a     | add -A
b     | branch
c     | commit
f     | fetch --all
s     | status
