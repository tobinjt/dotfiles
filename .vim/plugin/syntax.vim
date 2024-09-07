" Assume shell scripts are really using bash, so that we get bash-enhanced
" syntax.
let g:is_bash = 1
let g:sh_fold_enabled = 3

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

" Readline
" Add bash specific stuff
let readline_has_bash = 1

" Folding in various languages.
let g:vimsyn_folding = 'f'
let javaScript_fold = 1