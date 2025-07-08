" Contains misc plugin config where there isn't enough config to justify a
" separate file.

" Airline.  Change the status line so it doesn't need symbols missing from some
" fonts.
let g:airline_symbols_ascii = 1

" Signify.
" Disable VCS systems I don't use.
let g:signify_skip = {
      \  'vcs': {
      \    'allow': [
      \      'git',
      \      'hg',
      \      'perforce',
      \    ],
      \  }
      \}
