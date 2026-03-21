#!/bin/bash

set -e -f -u -o pipefail

main() {
  local directory
  directory="$(dirname "$0")"
  if [[ -n "${directory}" ]]; then
    cd "${directory}"
  fi
  run-nvim-command "lua require('plenary.busted').run('tools_spec.lua')"
}

main "$@"
