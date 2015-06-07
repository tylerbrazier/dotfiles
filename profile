# Some display managers source .profile instead of .bash_profile.

# The BASH_VERSION check is to ensure we're not in a /bin/sh shell.
[ -n "$BASH_VERSION" ] && [ -f ~/.bash_profile ] && source ~/.bash_profile
