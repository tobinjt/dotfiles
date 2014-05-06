#!/bin/bash
# Bash reads this when it's either an interactive login shell (-bash) or given
# the --login option.

. "${HOME}/.shell_profile"

prompt_command_shell_specific() {
  # Write new history lines.
  history -a
}
PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND

HISTIGNORE='&:fg:bg'
HISTCONTROL="ignoredups"
HISTTIMEFORMAT='%F %T '
HISTSIZE='1000000'
HISTFILESIZE='1000000000'
export HISTIGNORE HISTCONTROL HISTTIMEFORMAT HISTSIZE HISTFILESIZE
# Ignore files created by compiling Lisp.
FIGNORE=".lib:.fas:.fasl"
export FIGNORE

# Source aliases, per-shell or per-tty stuff.
. "${HOME}/.bashrc"

# Local stuff
local_bash_profile="${HOME}/.bash_profile-local"
if [ -f "${local_bash_profile}" ]; then
  . "${local_bash_profile}"
fi
