#!/bin/bash

set -e -f -u -o pipefail

set +f
# Strip out comments, newlines, and extra spaces, so the the generated file is
# proper JSON.
(echo '{'; sed -e '/\/\//d' "${HOME}"/.markdownlintrc.*; echo '}') \
  | tr -s '\n' ' ' \
  > "${HOME}/.markdownlintrc"
