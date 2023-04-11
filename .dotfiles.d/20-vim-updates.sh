#!/bin/bash

set -e -f -u -o pipefail

# Update vim helptags and spell files.

main() {
  # Stop TmuxSetWindowName loading: it's not useful and it doesn't work properly
  # when tmux is focused on a different pane.  'set t_u7=' stops '2R' appearing
  # in my shell input stream with older versions of vim.
  vim --cmd 'let g:loaded_TmuxSetWindowName=1' \
    --cmd 'set t_u7=' \
    -c 'call UpdateBundleHelptags() | call UpdateSpellFiles() | :quit'
}

main "$@"
