#!/usr/bin/env python

# Moves you to the next unused workspace and executes arguments to this script.
# Useful if you want to launch apps in their own workspaces.

from sys import argv
from json import loads
from subprocess import check_output, call

out = check_output(['i3-msg', '-t', 'get_workspaces']).decode('utf-8')
workspaces = [i['num'] for i in loads(out)]
next_ws = 1
while next_ws in workspaces:
    next_ws += 1

call(['i3-msg', 'workspace', str(next_ws)])
call(argv[1:])
