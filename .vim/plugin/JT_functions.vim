if !has("eval")
 finish
endif

function! Spell_check_comments()
  syntax match    spell_check_comment /^[[:space:]]*#.*/ contains=@Spell
  hi def link     spell_check_comment Comment
endfunction
" Return the name of the syntax highlighting group under the cursor.
function! SyntaxUnderCursor()
  echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction

" Initialise now so it always exists.
let s:last_search = ''
function! Grep(pattern)
  let s:last_search = a:pattern
  call ReGrep()
endfunction
function! ReGrep()
  " This can't work if there wasn't a previous search.
  if s:last_search == ''
    return
  endif
  let l:pattern = '/' . escape(s:last_search, '/') . '/j'
  let l:path = expand('%:h')
  " Handle there not being a filename; we don't want to start searching
  " from /.
  if l:path == ''
    let l:path = getcwd()
  endif
  let l:path = l:path . '/**'
  execute 'lvimgrep ' . l:pattern . ' ' . l:path
  lwindow
endfunction

function! TurnOffLineNumbersAndSigns()
  set nonumber norelativenumber signcolumn=no
endfunction
function! TurnOnLineNumbersAndSigns()
  set number relativenumber signcolumn=auto
endfunction

" This layer of indirection seems to be necessary for map().
function! s:Run(command)
  execute a:command
endfunction
" Update helptags for all bundles.
function! UpdateBundleHelptags()
  call map(split(glob('~/.vim/bundle/*/doc'), '\n'),
         \ 's:Run("helptags " . v:val)')
endfunction
" Update all spell files.
function! UpdateSpellFiles()
  call map(split(&spellfile, ','), 's:Run("mkspell! " . v:val)')
endfunction

" Functions to do magic things when you start editing a new file.
function! JT_populate_sh() "
  " Don't execute this function a second time.
  if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
    return
  endif
  insert
#!/bin/bash

set -e -f -u -o pipefail

.
  call cursor ( line ( "$" ), 0 )
  set filetype=sh
endfunction

" Create a directory if it does not exist.
function! JT_safe_mkdir(dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p", 0700)
  endif
endfunction
