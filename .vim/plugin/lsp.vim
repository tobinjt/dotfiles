" LSP
" Disable diagnostics, they are really intrusive.
let g:lsp_diagnostics_enabled = 0

" Config for https://github.com/prabirshrestha/vim-lsp
" https://github.com/mattn/vim-lsp-settings configures language servers.

if ! PluginLoaded('vim-lsp')
  finish
endif

augroup johntobin-lsp
autocmd!

" Disable LSP if there are conflict markers, and re-enable it afterwards.
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

autocmd BufReadPost * call DisableLSPForBufferWhenThereAreConflictMarkers()
autocmd BufWritePost * call ReenableLSPForBufferWhenThereWereConflictMarkers()

" Copied from https://github.com/prabirshrestha/vim-lsp#registering-servers
" and simplified somewhat.
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  setlocal tagfunc=lsp#tagfunc
endfunction
" Call s:on_lsp_buffer_enabled only for languages with registered servers.
autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

" Use LSP to format Rust.
autocmd BufWritePre *.rs LspDocumentFormatSync

augroup END
