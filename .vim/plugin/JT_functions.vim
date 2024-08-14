if !has('eval')
 finish
endif

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
function! TraditionalTabs()
  setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
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

" Run dot(1) and display errors on failure.
function! RunDot(file)
  let l:output = system('dot -O -Tpdf ' . shellescape(expand(a:file)))
  if v:shell_error != 0
    echomsg trim(l:output)
  endif
endfunction

function! OpenFoldUnderCursor()
  if foldlevel(line('.')) > 0
    foldopen!
  endif
endfunction

function! BufferHasConflictMarkers()
  " This is very simplistic but will likely work; if not, see
  " s:conflict_marker in autoload/airline/extensions/whitespace.vim
  let l:pattern = '^<\{7}\|^=\{7}\|>\{7}'
  return search(l:pattern, 'nw') != 0
endfunction

function! DisableLSPForBuffer()
  call lsp#disable_diagnostics_for_buffer()
endfunction

function! EnableLSPForBuffer()
  call lsp#enable_diagnostics_for_buffer()
endfunction

let g:disabled_lsp_due_to_conflict_markers = 0
function! DisableLSPForBufferWhenThereAreConflictMarkers()
  if BufferHasConflictMarkers()
    let g:disabled_lsp_due_to_conflict_markers = 1
    call DisableLSPForBuffer()
  endif
endfunction
function! ReenableLSPForBufferWhenThereWereConflictMarkers()
  if ! BufferHasConflictMarkers()
    let g:disabled_lsp_due_to_conflict_markers = 0
    call EnableLSPForBuffer()
  endif
endfunction
