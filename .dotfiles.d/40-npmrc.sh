#!/bin/bash

set -e -f -u -o pipefail

# Update ~/.npmrc with the correct path.  Assumes that the file contains no
# other configuration and isn't checked in.

main() {
  echo "prefix=${HOME}/tmp/bin/node_modules" > "${HOME}/.npmrc"
}

main "$@"
