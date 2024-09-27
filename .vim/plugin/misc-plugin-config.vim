" Contains misc plugin config where there isn't enough config to justify a
" separate file.

" NetRW.
" Stop loading netrw, it creates a history file.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" MatchParen.
" Stop the goddamn MatchParen plugin from loading.
let loaded_matchparen = 1

" Supertab
if plugin_loaded#plugin_loaded('supertab')
  " Use more clever completion.
  let g:SuperTabDefaultCompletionType = 'context'
  augroup johntobin-supertab
    autocmd!
    " If omnifunc is set use that first, then standard vim completion.
    autocmd FileType *
      \ if &omnifunc != '' |
      \   call SuperTabChain(&omnifunc, "<c-p>") |
      \ endif
  augroup END
endif
