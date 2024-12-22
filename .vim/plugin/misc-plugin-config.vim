" Contains misc plugin config where there isn't enough config to justify a
" separate file.

" NetRW.
" Stop loading netrw, it creates a history file.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" MatchParen.
" Stop the goddamn MatchParen plugin from loading.
let loaded_matchparen = 1

" Airline.  Change the status line so it doesn't need symbols missing from some
" fonts.
let g:airline_symbols_ascii = 1
