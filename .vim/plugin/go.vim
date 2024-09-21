" Golang
function! OpenFoldUnderCursor()
  if foldlevel(line('.')) > 0
    foldopen!
  endif
endfunction

augroup johntobin-golang
  autocmd!
  " Set a wide textwidth because Golang tends to have wide lines and airline
  " whitespace checks use textwidth.
  autocmd FileType go setlocal foldmethod=syntax textwidth=120 colorcolumn=
  " Autoformatting Go code on write causes folds to be closed; this autocmd opens
  " the fold under the cursor.
  autocmd BufWritePost *.go call OpenFoldUnderCursor()
augroup END

" vim-go.
" Install the necessary tools with; $ install-extra-tools-for-vim
" Use goimports, it should fix up import lines automatically.
let g:go_fmt_command = 'goimports'
" More highlighting.
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_debug_mappings = {
  \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
  \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
  \ '(go-debug-step)': {'key': 's'},
\}
