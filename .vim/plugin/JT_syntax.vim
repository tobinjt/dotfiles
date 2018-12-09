if !has("eval")
  finish
endif

" Assume shell scripts are really using bash, so that we get bash-enhanced
" syntax.
let is_bash = 1
let sh_fold_enabled = 3

" C source/headers: highlight strings and numbers within comments.
" Does this cause problems with PHP?  The highlighting can be a bit broken
" sometimes, enable this with care.  It looks nice though :)
let c_comment_strings = 1
" C source/headers: highlight gcc specific things.
let c_gnu = 1

" Perl settings:
" Highlight POD within Perl source.  see perldoc perlpod
let perl_include_pod = 1
" Highlight qq etc as statements rather than strings.
let perl_string_as_statement = 1
" Increase the number of lines vim looks at when highlighting Perl.
let perl_sync_dist = 500
" Folding settings.
let perl_fold = 1
let perl_fold_blocks = 1
let perl_nofold_packages = 1
let perl_no_scope_in_variables = 1

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

" Python settings.
" Turn on the maximum amount of highlighting.
let python_highlight_all = 1

" Readline
" Add bash specific stuff
let readline_has_bash = 1

" Go
" Disable Go's trailing space highlighting, mine is better because it
" ignores the current line.
let go_highlight_trailing_whitespace_error = 0

" Folding in various languages.
let tex_fold_enabled=1
let vimsyn_folding = "f"
let javaScript_fold = 1

" Settings for syntax/2html.vim.
let html_use_xhtml = 1
let html_ignore_folding = 1
