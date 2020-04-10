Personal Unix/Linux home configuration files, hosted on Github. To install:

	curl -L http://tylerbrazier.com/dotfiles/install.sh | bash

On Windows use [git bash](https://git-scm.com/download/win).

`.bash_profile` isn't included since it generally has machine-local settings.
At least, it should have:

	test -f ~/.bashrc && source ~/.bashrc
