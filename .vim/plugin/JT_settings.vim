" Don't be Vi compatible; things have moved on since 1980.  Users with ~/.vimrc
" won't be compatible anyway, but they shouldn't need one for Vim to work
" nicely.
set nocompatible

" Visual stuff. {{{1
" Use a visual flash rather than ringing the bell - should make life in LG8
" much more pleasant.
set visualbell
" Display 5 lines of context while moving through the file.
set scrolloff=5
" Show the position within the file in the status bar.
set ruler
" Don't highlight search results afterwards.
set nohlsearch
" Search as you type the search string.  Remember to hit return!
set incsearch
" Ignore case when searching . . . but see below
set ignorecase
" Don't ignore case if an uppercase letter was type in the pattern.
set smartcase
" Show matching (),{} and [] as you type.
set showmatch
" Show commands as you type.
set showcmd
" Open new windows below the current window (to the right with vsplit).
set splitbelow splitright
" Don't redraw the screen while executing macros etc.
set lazyredraw
" Show as much of the last line on screen as possible.
set display+=lastline

" File related stuff. {{{1
" Ignore files with these suffixes when doing tab completion.
set suffixes+=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx
set suffixes+=,.ilg,.inx,.out,.toc
" When tab-completing filenames, expand to the longest common substring on the
" first tab, then show a list on the second tab; basically behave the same as
" bash does.
set wildmode=longest,list
" Don't make backup copies of files.
set nobackup
" Ask the user if they want to save or abandon changes rather than failing.
set confirm
" Don't scan included files when doing completion.
set complete-=i
" Automatically reread a file when it's changed outside vim and not changed
" inside vim.
set autoread

" Formatting options. {{{1
" Automatically insert comment leaders after hitting return in Insert mode or
" O/o in Normal mode.
set formatoptions+=ro
if v:version > 703
  " Remove comment characters when joining lines.
  set formatoptions+=j
endif
set textwidth=80
" Turn on automatic indenting.
set autoindent

" Movement through the file. {{{1
" Proper backspace, that deletes previously entered text.
set backspace=indent,eol,start
" Make the arrow keys wrap - i.e. hitting left arraw at the start of a
" line will move the cursor to the end of the previous line.
set whichwrap+=<,>,b,[,]

" Compilation related stuff. {{{1
" make should run silently from within vim to help with quickfix mode.
set makeprg+=\ -s

" Completion settings
" Dictionary file to read - Linux/*BSD, Solaris.
set dictionary+=/usr/share/dict/words,/usr/share/lib/dict/words

" History {{{1
" Keep a history of commands type in command mode (after typing ':'), and
" searches.
set history=100
if has("+viminfo")
  " Default:
  "set viminfo='20,<50,s10,h
  set viminfo='100,<50,s10,h
endif
" Misc stuff, bugfixes. {{{1
" Prevent vim connecting to the X server so that using PuTTY works without
" Exceed.  This prevents cut and paste between Vim and the X server, but
" doesn't prevent cut and paste between the terminal and the X server.
" Selecting text within Vim won't copy it to the X server's clipboard, but
" selecting text from the terminal will.  You won't notice the difference
" unless you've got the mouse enabled.
set clipboard=exclude:.*
" Don't treat numbers starting with a 0 as octal.
set nrformats-=octal
" But do support incrementing single alphabetical characters.
set nrformats+=alpha

if has('multi_lang')
  language en_IE.UTF-8
endif
" This effectively maps F1 to :set paste!
set pastetoggle=<F1>

" Expand tabs to 2 spaces.
set expandtab tabstop=2 shiftwidth=2

" Enable smart tabs, to see what they do.
set smarttab

" Line numbers to make jumping easier.
set number

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

" Make % work with <>.
set matchpairs+=<:>

" Case-insensitive completion for filenames.
if exists('+wildignorecase')
  set wildignorecase
endif

if exists('+spellfile')
  set spellfile+=~/.vim/spell/en.utf-8.add
endif

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
  let html_use_xhtml = 1
  let html_ignore_folding = 1

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

  " Save undo history per file.
  if has("persistent_undo")
    let _undo_dir=_temp_dir . '/undo'
    if !isdirectory(_undo_dir)
      call mkdir(_undo_dir, "p", 0700)
    endif
    let &undodir=_undo_dir . "," . &undodir
    set undodir-=.
    set undofile
  endif
endif
