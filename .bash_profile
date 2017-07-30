#!/bin/bash
# Bash reads this when it's either an interactive login shell (-bash) or given
# the --login option.

# Source aliases, per-shell or per-tty stuff.
# shellcheck disable=SC1090
. "${HOME}/.bashrc"

# Local stuff
local_bash_profile="${HOME}/.bash_profile-local"
if [ -f "${local_bash_profile}" ]; then
  # shellcheck disable=SC1090
  . "${local_bash_profile}"
fi
