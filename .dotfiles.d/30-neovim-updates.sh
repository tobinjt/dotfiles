#!/bin/bash

set -e -f -u -o pipefail

main() {
  # Clean out treesitter .so files, otherwise they are never updated.
  #
  # I used to run :TSUpdate here, but it fails sometimes, so I stopped.  That
  # means that they will be compiled the next time I run nvim interactively, but
  # that's acceptable if not perfect.
  #
  # Note to self: this should be the last action so that it doesn't cause
  # problems for other nvim invocations.
  local treesitter_dir="${HOME}/.local/share/nvim/lazy/nvim-treesitter/parser"
  if [[ -d "${treesitter_dir}" ]]; then
    find "${treesitter_dir}" -type f -mtime +1 -name '*.so' -delete
  fi
}

main "$@"
