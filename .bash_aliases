#!/usr/bin/env bash

alias ls="ls -F" # --color=auto"
alias mv="mv -i"
alias cp="cp -i"

strip-quotes() {
  sed -e 's/"//g' -e "s/'//g"
}

top () {
	[ -z "$LINES" ] && LINES=24
	[ "$LINES" -lt 7 ] && LINES=24
	export TOP=$(( $LINES - 7 ))
	command top "$@"
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
rdesktop () {
    command rdesktop -g 90% "$@"
}
cdpwd () {
    cd "$( /bin/pwd )"
}

git () {
    # MacOS unset doesn't have --unset.
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

vimsplain () {
  (cd "${HOME}/src/Vimsplain" && python vimsplain.py "$@")
}

dotfiles() {
    linkdirs "$@" "${HOME}/src/dotfiles" "${HOME}"
    chmod 600 "${HOME}/.ssh/id_rsa"
    vim -c 'call UpdateBundleHelptags() | :quit'
}

# Adapted from http://www.chiark.greenend.org.uk/~sgtatham/aliases.html
_echo-literally-helper() {
    history 1 | perl -pe 's/^ *[0-9]+ +[^ ]+ //'
}
alias echo-literally='_echo-literally-helper #'

irssi() {
  TERM=xterm-color command irssi "$@"
}

functions() {
  set | grep '() $'
}

countsort() {
  sort "$@" | uniq -c | sort -n
}

alias python-functions='sed -n -e '\''s/^[[:space:]]\+def \([^(]\+\).*/\1/p'\'

only_duplicates() {
  fmt -1 "$@" \
    | sort \
    | uniq -d \
    | xargs echo
}

notifyme () {
  local answer=$?;
  local cmd="$(HISTTIMEFORMAT='!(Started at %T) ' history 2 \
                | head -n 1 \
                | cut -d '!' -f 2-)"
  if [[ "${answer}" == 0 ]]; then
    # notify-send is not available; need a replacement.
    notify-send -i info "$(date +%T) Success: $cmd" -t 240000;
  else
    notify-send -i error "$(date +%T) Failed: $cmd" -t 240000;
  fi
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
  if [[ -z "${pdir}" ]]; then
    echo "no directory found for pkg $1"
    return 1
  fi
  cd "${pdir}"
}
