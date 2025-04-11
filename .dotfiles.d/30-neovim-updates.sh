#!/bin/bash

set -e -f -u -o pipefail

# Sync Neovim plugins.
main() {
  # Clean out treesitter .so files, otherwise they are never updated.
  # TODO: figure out how to compile the deleted libraries, otherwise it happens
  # the next time I run nvim interactively.
  local treesitter_dir="${HOME}/.local/share/nvim/lazy/nvim-treesitter/parser"
  if [[ -d "${treesitter_dir}" ]]; then
    find "${treesitter_dir}" -type f -mtime +1 -delete
  fi
  # Lazy is very chatty, reduce noise.
  run-if-exists nvim --headless -c "Lazy! restore" -c "qa" > /dev/null
  run-if-exists nvim --headless -c "TSUpdate" -c "qa" > /dev/null
  # TSUpdate outputs a message without a newline.
  echo
}

main "$@"
