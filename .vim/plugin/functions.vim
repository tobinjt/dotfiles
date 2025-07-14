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

function! StartProfiling()
  profile start profile.log
  profile file *
  profile func *
endfunction
function! StopProfiling()
  profile stop
endfunction
