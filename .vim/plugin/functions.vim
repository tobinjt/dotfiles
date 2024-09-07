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

" This layer of indirection seems to be necessary for map().
function! s:Run(command)
  execute a:command
endfunction
" Update all spell files.
function! UpdateSpellFiles()
  call map(split(&spellfile, ','), 's:Run("mkspell! " . v:val)')
endfunction

" Functions to do magic things when you start editing a new file.
function! JT_populate_sh()
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

" Create a directory if it does not exist.
function! JT_safe_mkdir(dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p', 0700)
  endif
endfunction

" Set formatlistpat to my setting.  Relies on JT_settings.vim setting
" g:johntobin_formatlistpat.
function! JT_set_formatlistpat()
  let &formatlistpat = g:johntobin_formatlistpat
endfunction

function! OpenFoldUnderCursor()
  if foldlevel(line('.')) > 0
    foldopen!
  endif
endfunction

function! StartProfiling()
  profile start profile.log
  profile file *
  profile func *
endfunction
function! StopProfiling()
  profile stop
endfunction

function! MoveSwapAndTempAndUndoFilesToTmp()
  " Base directory.
  let l:_temp_base = expand('~/tmp/vim')

  " Move swapfiles.
  let l:_swap_dir = _temp_base . '/swap'
  call JT_safe_mkdir(l:_swap_dir)
  " Adding '//' means create the filename from the full path to prevent clashes.
  let &directory = l:_swap_dir . '//,' . &directory
  " Don't ever put swap files in the file's directory: it's bad on non-local
  " filesystems.
  set directory-=.

  " Move tempfiles.  I'm trying this again because long-lived vim sessions get
  " their temp directory removed sometimes; I don't see anything in
  " /var/log/daily.out, but I *feel* like it's related to updating homebrew
  " packages.
  let _temp_dir = l:_temp_base . '/tmp'
  call JT_safe_mkdir(l:_temp_dir)
  let $TMPDIR = l:_temp_dir

" Save undo history per file.
  if has('nvim')
    let l:_undo_dir = l:_temp_base . '/undo-nvim'
  else
    let l:_undo_dir = l:_temp_base . '/undo'
  endif
  call JT_safe_mkdir(l:_undo_dir)
  let &undodir = l:_undo_dir . ',' . &undodir
  set undodir-=.
endfunction
