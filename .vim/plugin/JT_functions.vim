if !has('eval')
 finish
endif

" Return the name of the syntax highlighting group under the cursor.
function! SyntaxUnderCursor()
  echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')
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

" Returns the line number of first line of the contiguous block containing
" start_line and having syntax ID syn_id throughout.
function! FindStartOfBlock(start_line, syn_id)
  let l:start_line = a:start_line
  while l:start_line > 0
    let l:len = len(getline(l:start_line))
    let l:curr_syn_id = synID(l:start_line, l:len, 1)
    if l:curr_syn_id != a:syn_id
      " We went one line too far, go back, and exit the loop.
      let l:start_line = l:start_line + 1
      break
    endif
    if l:start_line == 1
      break
    endif
    let l:start_line = l:start_line - 1
  endwhile
  return l:start_line
endfunction

" Returns the line number of last line of the contiguous block containing
" start_line and having syntax ID syn_id throughout.
function! FindEndOfBlock(start_line, syn_id)
  let l:end_line = a:start_line
  while l:end_line <= line('$')
    let l:len = len(getline(l:end_line))
    let l:curr_syn_id = synID(l:end_line, l:len, 1)
    if l:curr_syn_id != a:syn_id
      " We went one line too far, go back.
      let l:end_line = l:end_line - 1
      break
    endif
    let l:end_line = l:end_line + 1
  endwhile
  return l:end_line
endfunction

" Wraps the comment block that contains the cursor.  The cursor will be left at
" the end of the block.
function! WrapCommentBlock()
  " Using the syntax under the last character of the line so that this can be
  " called from before the comment character.  col('$') returns the last
  " character plus 1, so subtract 1 to get a valid index into the line.
  let l:syn_id = synID(line('.'), col('$') - 1, 1)
  let l:syn_name = synIDattr(l:syn_id, 'name')
  if match(l:syn_name, '\ccomment') == -1
    echomsg 'syntax does not contain "comment": ' l:syn_id . ' => ' . l:syn_name
    return
  endif

  let l:start_line = FindStartOfBlock(line('.'), l:syn_id)
  let l:end_line = FindEndOfBlock(line('.'), l:syn_id)

  call cursor(l:start_line, len(getline(l:start_line)))
  if l:end_line == l:start_line
    execute 'normal! gqgq'
  else
    execute 'normal! ' . (l:end_line - l:start_line) . 'gqgq'
  endif
endfunction
