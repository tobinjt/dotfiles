if ! has("termguicolors")
  " This happens with /usr/bin/vim on MacOS.
  " Suppress the error message from Solarized.
  finish
endif
" Use TrueColor (24 bit).
set termguicolors
set background=dark
let g:solarized_termtrans = 1
let g:solarized_diffmode = "low"
" let g:solarized_visibility = "normal"
colorscheme solarized8
