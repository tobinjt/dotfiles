#!/bin/bash

set -e -f -u -o pipefail

# Sync Neovim plugins.
main() {
  if type nvim >& /dev/null; then
    nvim --headless -c "Lazy! restore" -c "qa"
  fi
}

main "$@"
