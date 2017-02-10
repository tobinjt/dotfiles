#!/bin/bash
# Bash reads this when it's either an interactive login shell (-bash) or given
# the --login option.

if [ "$-" != "${-//i/}" ]; then
  # This is an interactive shell.
  # Source aliases, per-shell or per-tty stuff.
  . "${HOME}/.bashrc"
fi

# Local stuff
local_bash_profile="${HOME}/.bash_profile-local"
if [ -f "${local_bash_profile}" ]; then
  . "${local_bash_profile}"
fi
