#!/usr/bin/env bash
# This file is sourced (via .bash_profile) for login shells.
# This file is sourced (directly) for non-login, interactive shells.
# This file is sourced (directly) if bash thinks it's being run by rshd, and
#   presumably sshd too.
# aliases should be put here because they aren't passed on to child processes.

# Umask is here so that it's set when scp(1)ing.
umask 022

# Source prompt_command et al.
. "${HOME}/.shell_functions"
prompt_command_shell_specific() {
  # Write new history lines.
  history -a
}
PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND

# PS1 is overwritten by /etc/bash.bashrc.
if [ "${UID}" -eq 0 ]; then
  # Highlight root in my prompt as a warning.
  _user="$(echo -ne "\033[01;31m\\u\033[0m")"
else
  _user="\u"
fi
PS1="\nI'm ${_user} on \h's pts/\l @ \t, \d, in \w/\nWhat is thy bidding? "
# Trim \w in PS1 to 4 subdirectories.
PROMPT_DIRTRIM=4
export PS1 PROMPT_DIRTRIM

HISTIGNORE='&:fg:bg'
HISTCONTROL="ignoredups"
HISTTIMEFORMAT='%F %T '
HISTSIZE='1000000'
HISTFILESIZE='1000000000'
export HISTIGNORE HISTCONTROL HISTTIMEFORMAT HISTSIZE HISTFILESIZE

# Ignore files created by compiling Lisp.
FIGNORE=".lib:.fas:.fasl"
export FIGNORE

shopt -s checkhash
shopt -s checkwinsize
shopt -s extglob
shopt -s histappend
shopt -s histreedit
shopt -s no_empty_cmd_completion
if [ "${BASH_VERSINFO[0]}" -ge 4 ]; then
  # ** matches recursively.
  shopt -s globstar
fi
# Disable Posix mode: it's set when Bash is invoked as /bin/sh, and root's
# shell is /bin/sh on Mac OS X.
if [ -n "${BASH_VERSINFO}" ]; then
  set +o posix
fi

# Only do completion stuff if the shell is interactive, errors are generated
# otherwise - sh doesn't have completion, and this file is sourced by
# cronjobs.
. "${HOME}/.bash_completion"
# Likewise, only set up aliases when running interactively.
. "${HOME}/.shell_aliases"
if [ -n "${TMUX}" ]; then
  # Clear the pane title tmux sets - 'bash' is not informative.
  echo -ne "\033k\033\\"
fi

# Local stuff
local_bash_rc="${HOME}/.bashrc-local"
if [ -f "${local_bash_rc}" ]; then
  . "${local_bash_rc}"
fi
