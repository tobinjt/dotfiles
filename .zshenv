# Run for all shells, including shell scripts.
# Pull in $PATH etc so I can run 'ssh host command' where command is in ~/bin.
. "${HOME}/.shell_rc"
# Pull in tmux_attach so I can run it as 'ssh host tmux_attach'.
. "${HOME}/.shell_functions"
