#!/bin/bash

set -e -f -u -o pipefail

run_nvim() {
  # Stop TmuxSetWindowName loading: it's not useful and it doesn't work properly
  # when tmux is focused on a different pane.
  run-if-exists nvim --headless \
    --cmd 'let g:loaded_TmuxSetWindowName=1' \
    -c "$@" -c "qa" > /dev/null
}

# Sync Neovim plugins.
main() {
  # Clean out treesitter .so files, otherwise they are never updated.
  # TODO: figure out how to compile the deleted libraries, otherwise it happens
  # the next time I run nvim interactively.
  local treesitter_dir="${HOME}/.local/share/nvim/lazy/nvim-treesitter/parser"
  if [[ -d "${treesitter_dir}" ]]; then
    find "${treesitter_dir}" -type f -mtime +1 -delete
  fi
  run_nvim 'execute "mkspell! " &spellfile'
  # mkspell outputs a message without a newline.
  echo
  # Clean and sync plugins.
  run_nvim "Lazy! clean"
  run_nvim "Lazy! restore"
  # Update TreeSitter parsers.
  run_nvim "TSUpdate"
  # TSUpdate outputs a message without a newline.
  echo
  # Install or update tools installed using Mason.
  run_nvim "MasonToolsUpdateSync"
}

main "$@"
