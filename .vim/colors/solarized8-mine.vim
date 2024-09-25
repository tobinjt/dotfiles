" Wrap solarized8 so that I can reliably override parts of it.
" See :help colorscheme for more info about overrides.
let g:solarized_diffmode = 'low'
runtime colors/solarized8.vim
let g:colors_name = 'solarized8-mine'

" Highlight the first three characters over the line length limit.  Requires
" setting colorcolumn which is done in settings.vim.
"
" Clearing the highlight group first makes the background the same colour as the
" normal background, and then we change the colour of characters to red, so we
" only see this once we actually exceed the limit instead of highlighting the
" background of the columns.
highlight clear ColorColumn
highlight ColorColumn cterm=bold ctermfg=red gui=bold guifg=red guibg=background
" highlight ColorColumn cterm=bold gui=bold guibg=background
