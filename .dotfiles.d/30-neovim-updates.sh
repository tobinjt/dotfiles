#!/bin/bash

set -e -f -u -o pipefail

main() {
  # Clean out treesitter .so files, otherwise they are never updated.
  #
  # Note to self: this should be the last action so that it doesn't cause
  # problems for other nvim invocations.
  local treesitter_dir="${HOME}/.local/share/nvim/lazy/nvim-treesitter/parser"
  if [[ -d "${treesitter_dir}" ]]; then
    find "${treesitter_dir}" -type f -mtime +1 -name '*.so' -delete
  fi
  # TSUpdateSync doesn't block nvim exiting, so sleep for 10 seconds to give it
  # time to download and install.  10 seconds worked in testing and didn't feel
  # too long.
  run-nvim-command ":TSUpdateSync" -c "sleep 10"
}

main "$@"
