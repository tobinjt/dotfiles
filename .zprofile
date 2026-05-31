# shellcheck shell=bash
# Specifying the shell like above or a #! line is a shellcheck requirement, and
# it doesn't support zsh, so I'm pretending this is bash so that presubmit
# checks succeed.
#
# Run for login shells.

# Pull in my settings again so that they override system settings as necessary,
# in particular on Mac OS where /etc/zprofile overwrites $PATH.
. "${HOME}/.shellrc"
