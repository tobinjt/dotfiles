if !has("eval")
  finish
endif

" Folding in various languages
let perl_fold = 1
let perl_fold_blocks = 1
let perl_nofold_packages = 1
let perl_no_scope_in_variables = 1
let php_folding = 1

" Enable folding in TeX.
let tex_fold_enabled=1

" Stop the keymaps being fucked with by LatexSuite
let b:doneSetTeXOptions = 1
let Tex_SmartKeyQuote = 0

" Settings for syntax/2html.vim
let html_use_xhtml = 1
let html_ignore_folding = 1

let vimsyn_folding = "f"

let sh_fold_enabled = 3

let javaScript_fold = 1
