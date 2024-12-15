#!/bin/bash

set -e -f -u -o pipefail

# Sync Neovim plugins.
main() {
  # Lazy is very chatty, reduce noise.
  run-if-exists nvim --headless -c "Lazy! restore" -c "qa" > /dev/null
  run-if-exists nvim --headless -c "TSUpdate" -c "qa" > /dev/null
  # TSUpdate outputs a message without a newline.
  echo
}

main "$@"
