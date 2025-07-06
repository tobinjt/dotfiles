" Echo the name of the syntax highlighting group under the cursor.
function! SyntaxUnderCursor()
  echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction
function! SyntaxIDUnderCursor()
  echomsg synID(line('.'), col('.'), 1)
endfunction

function! TurnOffLineNumbersAndSigns()
  set nonumber norelativenumber signcolumn=no
endfunction
function! TurnOnLineNumbersAndSigns()
  set number relativenumber signcolumn=auto
endfunction

" Functions to do magic things when you start editing a new file.
function! PopulateSH()
  " Don't execute this function a second time.
  if (line('$') != 1 || getline('$') !=# '')
    return
  endif
  insert
#!/bin/bash

set -e -f -u -o pipefail

.
  call cursor(line('$'), 0)
  set filetype=sh
endfunction

" Set formatlistpat to my setting.  Relies on settings.vim setting
" g:johntobin_formatlistpat.
function! SetFormatlistpat()
  let &formatlistpat = g:johntobin_formatlistpat
endfunction

function! StartProfiling()
  profile start profile.log
  profile file *
  profile func *
endfunction
function! StopProfiling()
  profile stop
endfunction

function! MoveTempFilesToTmp()
  " Move tempfiles.  I'm trying this again because long-lived vim sessions get
  " their temp directory removed sometimes; I don't see anything in
  " /var/log/daily.out, but I *feel* like it's related to updating homebrew
  " packages.
  let _temp_dir = expand('~/tmp/vim/tmp')
  call mkdir(l:_temp_dir, 'p', 0700)
  let $TMPDIR = l:_temp_dir
endfunction
