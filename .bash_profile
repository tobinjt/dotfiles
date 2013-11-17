#!/bin/bash
# Bash reads this when it's either an interactive login shell (-bash) or given
# the --login option.

. "${HOME}/.shell_profile"

# Set the title in xterms etc.
function prompt_command() {
    exit_status="$?"
    # Exit status 148 happens when you suspend something.
    if [ "${exit_status}" != 0 -a "${exit_status}" != 148 ]; then
      echo -e "\033[01;31mExit status: ${exit_status}\033[0m"
    fi
    # Write new history lines.
    history -a
    # Read new history lines; actually don't, because this screws up the current
    # shell's history - up-arrow+return doesn't do what you expect.
    # history -n
    case "${TERM}" in
        xterm*|rxvt*|screen*)
            if [ -z "${TMUX}" ]; then
              echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD/${HOME}/~}\007"
            fi
            ;;
        *)
            ;;
    esac
    if [ -n "${TMUX}" ]; then
      local _tmux_env
      _tmux_env=$( tmux show-environment )
      if [ "${_tmux_env}" != "${_expected_tmux_env}" ]; then
        eval $( echo "${_tmux_env}" | \
                  sed -e '/^-/!{ s/=/="/; s/$/"/; s/^/export /; }' \
                      -e 's/^-/unset /' \
                      -e '/^./s/$/;/' )
        _expected_tmux_env="${_tmux_env}"
      fi
    fi
    prompt_command_extras
}
prompt_command_extras() {
  true
}
PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND
export -f prompt_command prompt_command_extras

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
