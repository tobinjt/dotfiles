" vim: set foldmethod=marker :
" Global vimrc for CS machines.

" Major settings first. {{{1

" Avoid parsing this file a second time.
if exists("g:read_CS_vimrc")
  finish
endif
if has("eval")
  let g:read_CS_vimrc = 1
endif

" Don't be Vi compatible; things have moved on since 1980.  Users with ~/.vimrc
" won't be compatible anyway, but they shouldn't need one for Vim to work
" nicely.
set nocompatible

" Enable for debugging.
"set verbose=


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

" Syntax highlighting related settings. {{{1
if has("eval")
  " Shell scripts {{{1
  " Assume shell scripts are really using bash, so that we get bash-enhanced
  " syntax.
  let is_bash = 1

  " C source/headers: highlight strings and numbers withing comments. {{{1
  " Does this cause problems with PHP?  The highlighting can be a bit broken
  " sometimes, enable this with care.  It looks nice though :)
  let c_comment_strings = 1
  " C source/headers: highlight gcc specific things.
  let c_gnu = 1

  " Perl settings: {{{1
  " Highlight POD within Perl source.  see perldoc perlpod
  let perl_include_pod = 1
  " Highlight qq etc as statements rather than strings.
  let perl_string_as_statement = 1
  " Increase the number of lines vim looks at when highlighting Perl.
  let perl_sync_dist = 500

  " PHP settings: {{{1
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
  " PHP folding - see Perl folding for details.
  "let php_folding = 1

  " Python settings. {{{1
  " Turn on the maximum amount of highlighting.
  let python_highlight_all = 1

  " Readline {{{1
  " Add bash specific stuff
  let readline_has_bash = 1

  " Go {{{1
  " Disable Go's trailing space highlighting, mine is better because it
  " ignores the current line.
  let go_highlight_trailing_whitespace_error = 0

  " Autocommands {{{1
  " Setting up autocommands; these are actions which will be automatically taken
  " at various times.
  if has("autocmd")
    " Taken from Bram Moolenar's example vimrc:
    " Jump to the previous position in the file.
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ 	exe "normal g`\"" |
      \ endif
    " Assume foo.t is Perl; Perl Modules come with tests in t/*.t
    autocmd BufEnter *.t setlocal ft=perl
    " Auto-wrap text, autowrap comments, allow fomment formatting, don't break
    " lines that are longer than textwidth when insertion starts.
    " :help fo-table for more details.
    autocmd FileType pod setlocal formatoptions+=tcql
    " Load omnicompletion 
    if exists("+omnifunc")
      autocmd FileType c          setlocal omnifunc=ccomplete#Complete
      autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript
        \ setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
      autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
      autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
    endif

    if has("eval")
      " More autocommands: call functions to do magic things when editing
      " various new files.
      autocmd BufNewFile *.pl,*.pm,*.cgi,*.t call CS_populate_perl()
      autocmd FileType perl call CS_populate_perl()
    endif
  endif

endif
