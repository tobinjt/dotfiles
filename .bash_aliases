#!/usr/bin/env bash

alias ls="ls -F" # --color=auto"
alias mv="mv -i"
alias cp="cp -i"

strip-quotes() {
  sed -e 's/"//g' -e "s/'//g"
}

top () {
  TOP="$((${LINES:-24} - 7))" command top "$@"
}
sortdu () {
	if [ "$#" = 0 ]; then
		du -sxk * .??* | sort -n
	else
		du -sxk "$@" | sort -n
	fi
}
hsdu () {
    sortdu "$@" | awk '{ $1 = $1 * 1024; print; }' | human
}
strictperl () {
    perl -Mstrict -w -MData::Dumper "$@"
}
cdpwd () {
    cd "$(/bin/pwd)"
}

git () {
    # MacOS env doesn't have --unset.
    ( unset LESS; exec git "$@" )
}

ikiwiki-johntobin.ie () {
    ikiwiki --setup ~/.ikiwiki/johntobin.ie "$@"
}

ikiwiki-johntobin.ie-preview () {
    ikiwiki-johntobin.ie --render "$@" | w3m -T text/html
}

clisp () {
    (ulimit -v 1048576 && command clisp -ansi -m 128MB "$@")
}

bc() {
  if [ -t 0 -a "$#" -eq 0 ]; then
    command bc -q -i "${HOME}/.bcrc"
  else
    command bc "$@"
  fi
}

# Provide a hook for local actions in dotfiles().
dotfiles_local() {
  true
}
dotfiles() {
    linkdirs "$@" "${HOME}/src/dotfiles" "${HOME}"
    chmod 600 "${HOME}/.ssh/id_rsa"
    vim -c 'call UpdateBundleHelptags() | :quit'
    dotfiles_local
}

# Adapted from http://www.chiark.greenend.org.uk/~sgtatham/aliases.html
_echo-literally-helper() {
    history 1 | perl -pe 's/^ *[0-9]+ +[^ ]+ //'
}
alias echo-literally='_echo-literally-helper #'

irssi() {
  TERM=xterm-color command irssi "$@"
}

shell_functions() {
  set | grep '() $'
}

countsort() {
  sort "$@" | uniq -c | sort -n
}

alias python-functions='sed -n -e '\''s/^[[:space:]]\+def \([^(]\+\).*/\1/p'\'

only_duplicates() {
  fmt -1 "$@" | sort | uniq -d | xargs echo
}

delete-ipad-app-backups() {
    rm "${HOME}/Music/iTunes/iTunes Media/Mobile Applications"/*
}

godocl() {
  godoc "$@" | less
}
godocf() {
  godoc "$@" | grep ^func
}
godocserver() {
  echo "http://localhost:23579/"
  godoc --http=:23579
}
gocovr() {
  gocov test "$@" | gocov report
}
gocovrx() {
  gocovr "$@" | grep -v -F 100.00
}
gocova() {
  gocov test "$@" | gocov annotate /dev/stdin "$@" | less +/MISS
}
gocdpkg() {
  local pdir
  pdir="$(go list -f '{{ .Dir }}' "$1")"
  if [ -z "${pdir}" ]; then
    echo "no directory found for pkg $1"
    return 1
  fi
  cd "${pdir}"
}
