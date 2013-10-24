#!/bin/bash
# Bash reads this when it's either an interactive login shell (-bash) or given
# the --login option.

# If homebrew is in use, put it first so I can replace system binaries like
# vim.
if [ -d "/usr/local/Cellar" ]; then
    PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
fi
PATH="${HOME}/gbin:${HOME}/bin:${HOME}/src/gopath/bin:${PATH}"
PATH="${PATH}:/sbin:/usr/sbin"
# Remove duplicate elements from $PATH while preserving order.
# This cannot use gawk features because it needs to be portable to Mac OS X.
PATH="$(echo "${PATH}" \
          | awk -F : \
              'BEGIN { output = ""; };
               { for (i = 1; i <= NF; i++) {
                   if (!($i in seen)) {
                     seen[$i] = 1;
                     output = output ":" $i;
                   }
                 }
               }
               END { sub("^:", "", output);
                     print output; }')"
export PATH

# The trailing : is important on Linux; it means to append the standard
# search path to ${MANPATH}.
MANPATH="${HOME}/man${MANPATH:+:}${MANPATH:-}:"
# Where Go should install stuff.
# Also trick Go into finding things in ~/src.
GOPATH="${HOME}/src/gopath:${HOME}${GOPATH:+:}${GOPATH:-}"
export MANPATH GOPATH

# Load cached ssh-agent environment variables.
. "${HOME}/.bash_ssh_agent"

# Replace xterm* with the best available.
case "${TERM}" in
    xterm*)
        for term in xterm xterm-color xterm-256color; do
            if tput -T"${term}" longname > /dev/null 2>&1; then
                TERM="${term}"
            fi
        done
    ;;
esac
export TERM

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

USERNAME="${USER}"
export USERNAME

BROWSER="google-chrome"
EDITOR="vim"
PAGER="less"
# make less more friendly for non-text input files, see lesspipe(1)
if type lesspipe > /dev/null 2>&1; then
    eval "$(lesspipe)"
fi
# smart case matching; long prompt; suppress dumb terminal error messages;
# allow ANSI colour escape sequences; highlight the first new line when
# moving through the file
LESS="iMdRW${LESS}"
export BROWSER EDITOR LESS PAGER

# If grep is happy with these options then export them for automatic use
GREP_OPTIONS='--color=auto'
if (echo foo | GREP_OPTIONS="${GREP_OPTIONS}" grep -q foo 2> /dev/null); then
    export GREP_OPTIONS
else
    unset GREP_OPTIONS
fi

HISTIGNORE='&:fg:bg'
HISTCONTROL="ignoredups"
HISTTIMEFORMAT='%F %T '
HISTSIZE='1000000'
HISTFILESIZE='1000000000'
export HISTIGNORE HISTCONTROL HISTTIMEFORMAT HISTSIZE HISTFILESIZE
# Ignore files created by compiling Lisp.
FIGNORE=".lib:.fas:.fasl"
export FIGNORE

LC_COLLATE="C"
# vim depends on $LC_ALL to set the language and encoding it uses.
LANG="en_IE.UTF-8"
LC_ALL="${LANG}"
LANGUAGE="${LANG}"
export LC_COLLATE LANG LC_ALL LANGUAGE

# make electric fence not return memory.
EF_PROTECT_FREE="1"
EF_ALIGNMENT="0"
#LD_PRELOAD=libefence.so.0.0
export EF_PROTECT_FREE EF_ALIGNMENT

# Make sure various programs use the correct address.
DEBEMAIL="tobinjt@cs.tcd.ie"
DEBUILD_LINTIAN_OPTS='--verbose --info --display-info --display-experimental --color=auto --show-overrides --md5sums'
DH_ALWAYS_EXCLUDE="CVS:.svn"
# Taken from http://chistera.yi.org/~adeodato/blog/104_quilt_options
# Put patches in debian/patches; if I ever use quilt for anything else, I'll
# make this more intelligent.
QUILT_PATCHES="debian/patches"
QUILT_DIFF_ARGS="-p ab --no-timestamps --no-index --color=auto"
QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"
export DEBEMAIL DEBUILD_LINTIAN_OPTS DH_ALWAYS_EXCLUDE QUILT_PATCHES
export QUILT_DIFF_ARGS QUILT_REFRESH_ARGS


# Source aliases, per-shell or per-tty stuff.
. "${HOME}/.bashrc"

# Local stuff
local_bash_profile="${HOME}/.bash_profile-local"
if [ -f "${local_bash_profile}" ]; then
  . "${local_bash_profile}"
fi
