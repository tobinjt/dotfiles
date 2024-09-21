#!/bin/bash

set -e -f -u -o pipefail

# Sync Neovim plugins.
main() {
  if type nvim >& /dev/null; then
    # Lazy is very chatty, reduce noise.
    nvim --headless -c "Lazy! restore" -c "qa" > /dev/null
  fi
}

main "$@"
