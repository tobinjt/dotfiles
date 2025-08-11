#!/bin/bash

set -e -f -u -o pipefail

set +f
(echo '{'; cat "${HOME}"/.markdownlintrc.*; echo '}') > "${HOME}/.markdownlintrc"
