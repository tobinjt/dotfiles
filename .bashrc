#!/usr/bin/env bash
# This file is sourced (via .bash_profile) for login shells.
# This file is sourced (directly) for non-login, interactive shells.
# This file is sourced (directly) if bash thinks it's being run by rshd, and
#   presumably sshd too.
# We do enough to set $PATH, then check for being an interactive shell: if we're
#   not interactive we skip everything else.
# aliases belong in .shell_aliases.

# Source shell-neutral environment settings.
# shellcheck disable=SC1090
. "${HOME}/.shellrc"

if [ "$-" == "${-//i/}" ]; then
  # This is not an interactive shell, skip everything else in this file to
  # prevent errors when this file is sourced by sh.
  return
fi

# Shell-neutral aliases.
# shellcheck disable=SC1090
. "${HOME}/.shell_aliases"

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

# Load system and Homebrew bash completion if available.  Both will source
# ~/.bash_completion if it exists, so this file needs to be named something
# else.
if [ -f /etc/bash_completion ]; then
  # shellcheck disable=SC1091
  . /etc/bash_completion
fi
if [ -f "/usr/local/etc/bash_completion" ]; then
  # shellcheck disable=SC1091
  . "/usr/local/etc/bash_completion"
fi

# Make tab completion only show directories when completing cd and rmdir
complete -A directory -o bashdefault rmdir pushd
# Additionally ignore VCS directories.
complete -A directory -o bashdefault -X '*@(.git|.svn|CVS)' cd
# unset complete on variable names
complete -A variable unset
# set completes on shell options
complete -A setopt set
# shopt completes with shopt options
complete -A shopt shopt
# unalias completes with aliases
complete -A alias unalias
# command, type and which complete on commands
complete -A command type which command
# builtin completes on builtins
complete -A builtin builtin

# Local stuff
local_bash_rc="${HOME}/.bashrc-local"
if [ -f "${local_bash_rc}" ]; then
  # shellcheck disable=SC1090
  . "${local_bash_rc}"
fi
