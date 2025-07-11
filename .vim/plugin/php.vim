augroup johntobin-php
  autocmd!
  " Automatic indentation is awful, disable it.
  autocmd FileType php setlocal foldtext=foldtext() indentexpr= shiftwidth=4
augroup END
