#!/usr/bin/env bash

alias ls="ls -F" # --color=auto"
alias mv="mv -i"
alias cp="cp -i"
prompt_cleanup () {
	unset __PROMPT_PL __PROMPT_PL_WRITE __PROMPT_PL_READ __PROMPT_PL_TRIED 
	source $HOME/.bashrc
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
titlebar () {
    export TITLEBAR="$@"
}

svnsummary () {
    if [ "$#" = 0 ]; then
        svnsummary .
    else
        (   svn status "$@";
            svn diff "$@" | diffstat;
            svn diff "$@" | colordiff;
        ) | ${PAGER:-less}
    fi
}

reprepro () {
    if [ -d "/software/apt/debian" ]; then
        basedir="--base /software/apt/debian"
    fi
    ( umask 002; command reprepro $basedir --verbose "$@" )
}

lintian () {
    command lintian $DEBUILD_LINTIAN_OPTS "$@"
}

clean () {
    fakeroot debian/rules clean "$@"
}

git () {
    # MacOS unset doesn't have --unset.
    ( unset LESS; exec git "$@" )
}

reprepro-ubuntu () {
    ( umask 002; command reprepro --base /software/apt/ubuntu --verbose "$@" )
}

remove-package-build-files () {
    rm *.deb *.dsc *.build *.changes *.diff.gz
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

dtach () {
    if [ "$#" -lt 2 ]; then
        command dtach --help
    else
        switch="$1"
        socket="$2"
        shift 2
        command dtach "$switch" "$socket" -r winch -z "$@"
    fi
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

godocserver() {
  godoc --http=:23579
}