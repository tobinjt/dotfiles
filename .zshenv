# shellcheck shell=bash
# Specifying the shell like above or a #! line is a shellcheck requirement, and
# it doesn't support zsh, so I'm pretending this is bash so that presubmit
# checks succeed.
#
# Run for all shells, including shell scripts.
# Pull in $PATH etc so I can run 'ssh host command' where command is in ~/bin.
. "${HOME}/.shellrc"
