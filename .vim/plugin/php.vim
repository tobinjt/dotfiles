" PHP settings:
" Highlight SQL queries inside strings.
let php_sql_query = 1
" Highlight basic PHP functions.
let php_baselib = 1
" Highlight HTML within strings.
let php_htmlInStrings = 1
" Don't highlight <? as valid start-of-PHP tags; people should use <?php
let php_noShortTags = 1
" Highlight ()[] related errors.
" I'm honestly not sure what these do.
let php_parent_error_close = 1
let php_parent_error_open = 1
" PHP folding: fold classes and functions.
let php_folding = 1

" --- Configure PHP checkers.  Untested, ported from Syntastic.
let g:ale_php_phplint_args = '--modules-path ../phplint-modules'
let g:ale_php_phplint_args .= ' --no-ascii-ext-check'
" Use the level defined in phpstan.neon.
let g:ale_php_phpstan_args = []

augroup johntobin-php
  autocmd!
  autocmd FileType php setlocal foldtext=foldtext()
augroup END
