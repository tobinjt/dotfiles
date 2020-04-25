#!/usr/bin/env bash
# This file is sourced (via .bash_profile) for login shells.
# This file is sourced (directly) for non-login, interactive shells.
# This file is sourced (directly) if bash thinks it's being run by rshd, and
#   presumably sshd too.
# We do enough to set $PATH, then check for being an interactive shell: if we're
#   not interactive we skip everything else.
# aliases should be put here because they aren't passed on to child processes.

# Umask is here so that it's set when scp(1)ing.
umask 022

# Source prompt_command et al.
# shellcheck disable=SC1090
. "${HOME}/.shell_functions"
# Source shell-neutral environment settings.
# shellcheck disable=SC1090
. "${HOME}/.shell_rc"

if [ "$-" == "${-//i/}" ]; then
  # This is not an interactive shell, skip everything else in this file.
  return
fi

prompt_command_shell_specific() {
  # Write new history lines.
  history -a
}
PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND

# PS1 is overwritten by /etc/bash.bashrc.
if [ "${USER}" != "johntobin" ]; then
  # Highlight other users in my prompt as a warning.
  _user="\\033[01;31m\\u\\033[0m"
else
  _user="\\u"
fi
PS1="\\nI'm ${_user} on \\h's \\l @ \\t, \\d, in \\w/"
PS1="${PS1}\\nWhat is thy bidding? "
# Trim \w in PS1 to 4 subdirectories.
PROMPT_DIRTRIM=4
export PS1 PROMPT_DIRTRIM

# Exclude fg and bg from history.
HISTIGNORE='&:fg:bg'
HISTCONTROL="ignoredups"
HISTTIMEFORMAT='%F %T '
HISTSIZE='100000000'
HISTFILESIZE='100000000000'
export HISTIGNORE HISTCONTROL HISTTIMEFORMAT HISTSIZE HISTFILESIZE

# Ignore files created by compiling Lisp or Python.
FIGNORE=".lib:.fas:.fasl:.pyc:.pyo"
export FIGNORE

# Fix minor spelling errors in cd arguments.
shopt -s cdspell
# Check that a hashed command exists before execution and search again if not
# found.
shopt -s checkhash
# Check window size after each command.
shopt -s checkwinsize
# Save multiline commands as a single history entry for easy editing.
shopt -s cmdhist
# Enable extended pattern matching in globs, e.g. !(*.gz).
shopt -s extglob
# Append to the history file rather than overwriting.
shopt -s histappend
# Failed command substitutions can be reedited.
shopt -s histreedit
# History substitutions will be expanded rather than executed so they can be
# verified.
shopt -s histverify
# Don't do tab completion on empty lines
shopt -s no_empty_cmd_completion
# Output an error message when trying to shift more args than exist.
shopt -s shift_verbose

if [ "${BASH_VERSINFO[0]}" -ge 4 ]; then
  # Check for running background jobs and warn before exiting.
  shopt -s checkjobs
  # Expand ${foo} when doing tab completion.
  shopt -s direxpand
  # Correct spelling of directories during filename completion.
  shopt -s dirspell
  # [a-z] doesn't include B, i.e. do what I expect.
  shopt -s globasciiranges
  # ** matches recursively.
  shopt -s globstar
fi
# Disable Posix mode: it's set when Bash is invoked as /bin/sh, and root's
# shell is /bin/sh on Mac OS X.
if [ -n "${BASH_VERSION}" ]; then
  set +o posix
fi

# Only do completion stuff if the shell is interactive, errors are generated
# otherwise - sh doesn't have completion, and this file is sourced by
# cronjobs.
# Load Homebrew bash completion if available.  On Linux bash completion is
# normally loaded automatically.
if [ -f "/usr/local/etc/bash_completion" ]; then
  # shellcheck disable=SC1091
  . "/usr/local/etc/bash_completion"
fi
# My own completions.
# shellcheck disable=SC1090
. "${HOME}/.bash_completion"
# Likewise, only set up aliases when running interactively.
# shellcheck disable=SC1090
. "${HOME}/.shell_aliases"

# Local stuff
local_bash_rc="${HOME}/.bashrc-local"
if [ -f "${local_bash_rc}" ]; then
  # shellcheck disable=SC1090
  . "${local_bash_rc}"
fi
