#!/bin/bash

set -e -f -u -o pipefail

# This is duplicated in ~/bin/dotfiles.
dotfiles_sources() {
  find "${HOME}/src" -maxdepth 1 -iname '*dotfiles*' -type d
}

cat_some_files() {
  local dir="$1" pattern="$2"
  find "${dir}" \
      -name "${pattern}" \
      -a \( -not -name '*-os-*' -o -name '*-os-'"$(uname -s)"'-*' \) \
      -print0 \
    | sort --zero-terminated \
    | xargs -0 cat --
}

cat_ssh_configs() {
  cat_some_files "${HOME}"/.ssh 'config-??-*'
}

cat_ssh_known_hosts() {
  cat_some_files "${HOME}"/.ssh 'known_hosts-??-*'
}

main() {
  # ssh complains about loose permissions on ~/.ssh, so tighten them.
  find "${HOME}"/.ssh -type f -print0 | xargs -0 chmod 600
  local dir
  for dir in "${HOME}" $(dotfiles_sources); do
    if [[ -d "${dir}/.ssh" ]]; then
      chmod 700 "${dir}/.ssh"
    fi
  done

  # Assemble ssh config.
  cat_ssh_configs > /dev/null
  cat_ssh_configs > "${HOME}/.ssh/config"

  # Assemble ssh known_hosts.
  local tmp_known_hosts known_hosts="${HOME}/.ssh/known_hosts"
  if [[ ! -e "${known_hosts}" ]]; then
    touch "${known_hosts}"
    chmod 600 "${known_hosts}"
  fi
  tmp_known_hosts="$(mktemp -t known_hosts.XXXXXXXXXX)"
  # I want ${tmp_known_hosts} to be expanded now, because when we exit
  # successfully it will be out of scope and cannot be expanded.
  # shellcheck disable=SC2064
  trap "rm -f \"${tmp_known_hosts}\"" EXIT
  cat_ssh_known_hosts > "${tmp_known_hosts}"
  # shellcheck disable=SC2094
  # The disabled warning is about reading from and writing to the same file in a
  # single command; in this case it's fine because sort needs to read the entire
  # input before sorting, so there's no race condition.
  # Strip existing entries from tmp_known_hosts, then append the output to
  # known_hosts so that missing entries are added.
  sort "${known_hosts}" "${known_hosts}" "${tmp_known_hosts}" \
    | uniq -u >> "${known_hosts}"
}

main "$@"
