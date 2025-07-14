#!/bin/bash

set -e -f -u -o pipefail

# Update vim helptags and spell files.

main() {
  # Stop TmuxSetWindowName loading: it's not useful and it doesn't work properly
  # when tmux is focused on a different pane.
  vim --cmd 'let g:loaded_TmuxSetWindowName=1' \
    -c 'execute "mkspell! " &spellfile' \
    -c ':quit'
}

main "$@"
