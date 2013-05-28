" This effectively maps F1 to :set paste!
set pastetoggle=<F1>

" Expand tabs to 2 spaces.
set expandtab tabstop=2 shiftwidth=2

" Enable smart tabs, to see what they do.
set smarttab

" Change the xterm title, but not under tmux.
if has('title') && ! exists("$TMUX")
    set title
endif

" Don't sync the swap file
set swapsync=

" Always display a status line.
set laststatus=2

" Recognise extra list headers.  Use let instead of set, to avoid backslashitis.
let &formatlistpat='^\s*\(\d\+\|\a\+\.\|\*\)[.:)]\s*'

" Settings required for LaTeX-suite:
if has('+shellslash')
    set shellslash
endif
set grepprg=grep\ -nH\ $*

if has("eval")
    " Folding in various languages
    let perl_fold = 1
    let perl_fold_blocks = 1
    let perl_nofold_packages = 1
    let perl_no_scope_in_variables = 1
    let php_folding = 1

    " Stop the goddamn MatchParen plugin from loading.
    let loaded_matchparen = 1

    " Enable folding in TeX.
    let tex_fold_enabled=1

    " Stop the keymaps being fucked with by LatexSuite
    let b:doneSetTeXOptions = 1
    let Tex_SmartKeyQuote = 0

    " Settings for syntax/2html.vim
    let use_xhtml = 1
    let html_use_css = 1
    let html_ignore_folding = 1
    let html_number_lines = 1

    let Twiki_SourceHTMLSyntax = 1
    let Twiki_Functions = 1

    let vimsyn_folding = "f"

    " Enable folding of heredocs and functions.
    let sh_fold_enabled = 3

    let javaScript_fold = 1
endif

if has("user_commands")
    " Taken from :help :DiffOrig - this should diff the current buffer against
    " the file on disk.
    command DiffOrig vert new "| set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" Move swapfiles to a local directory.
if has("eval")
  let _temp_dir="/var/tmp/" . $USER
  if !isdirectory(_temp_dir)
    call mkdir(_temp_dir, "p", 0700)
  endif
  let &directory=_temp_dir . "//," . &directory
endif
