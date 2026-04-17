#!/bin/bash

set -e -f -u -o pipefail

main() {
  # Update plugins managed by Lazy.
  run-nvim-command 'Lazy! clean'
  run-nvim-command 'Lazy! update' > /dev/null
  # Install and update Treesitter parsers.
  run-nvim-command \
    'lua require("johntobin.functions").InstallAndUpdateTreesitterParsers()' \
    > /dev/null
}

main "$@"
