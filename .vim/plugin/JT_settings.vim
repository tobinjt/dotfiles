" Visual stuff.
" Use a visual flash rather than ringing the bell.
set visualbell
" Display 8 lines of context while moving through the file.
set scrolloff=8
" Show the position within the file in the status bar.
set ruler
" Always display a status line.
set laststatus=2
" Highlight the current line.
set cursorline
" Line numbers to make jumping easier.
set number relativenumber
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
" Open new windows below the current window (to the right with vsplit), and make
" them equal size.
set splitbelow splitright equalalways
" Don't redraw the screen while executing macros etc.
set lazyredraw
" Show as much of the last line on screen as possible.
set display+=lastline
" Change the xterm title, but not under tmux.
if has('title') && ! exists('$TMUX')
  set title
endif

" File related stuff.
" Disable modelines because of security vulnerability.
" http://seclists.org/oss-sec/2016/q4/506
if v:version < 801
  set nomodeline
endif
" Ignore files with these suffixes when doing tab completion.
set suffixes+=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx
set suffixes+=,.ilg,.inx,.out,.toc
" When tab-completing filenames, expand to the longest common substring on the
" first tab, then move through options on the second and subsequent tabs;
" basically behave the same as zsh does.
set wildmenu
set wildmode=longest,full
" Don't make backup copies of files.
set nobackup
" Ask the user if they want to save or abandon changes rather than failing.
set confirm
" Don't scan included files when doing completion.
set complete-=i
" Automatically reread a file when it's changed outside vim and not changed
" inside vim.
set autoread
" Don't sync the swap file
if !has('nvim')
  set swapsync=
endif
" Case-insensitive completion for filenames.
if exists('+wildignorecase')
  set wildignorecase
endif

" Use pipes instead of tempfiles when possible.  system() ignores this setting.
if has('filterpipe')
  set noshelltemp
endif

" Move swapfiles to ~/tmp/vim.
if has('eval')
  " Base directory.
  let _temp_base = expand('~/tmp/vim')

  " Move swapfiles.
  let _swap_dir = _temp_base . '/swap'
  call JT_safe_mkdir(_swap_dir)
  " Adding '//' means create the filename from the full path to prevent clashes.
  let &directory = _swap_dir . '//,' . &directory
  " Don't ever put swap files in the file's directory: it's bad on non-local
  " filesystems.
  set directory-=.

  " Move tempfiles.  I'm trying this again because long-lived vim sessions get
  " their temp directory removed sometimes; I don't see anything in
  " /var/log/daily.out, but I *feel* like it's related to updating homebrew
  " packages.
  let _temp_dir = _temp_base . '/tmp'
  call JT_safe_mkdir(_temp_dir)
  let $TMPDIR = _temp_dir

  " Save undo history per file.
  if has('persistent_undo')
    if has('nvim')
      let _undo_dir = _temp_base . '/undo-nvim'
    else
      let _undo_dir = _temp_base . '/undo'
    endif
    call JT_safe_mkdir(_undo_dir)
    let &undodir = _undo_dir . ',' . &undodir
    set undodir-=.
    set undofile
  endif
endif

" Formatting options.
" Automatically insert comment leaders after hitting return in Insert mode or
" O/o in Normal mode.
set formatoptions+=ro
" Remove comment characters when joining lines.
set formatoptions+=j
" Recognise lists; see formatlistpat below for accepted styles.
set formatoptions+=n
set textwidth=80
" Turn on automatic indenting.
set autoindent
" This effectively maps F1 to :set paste!
set pastetoggle=<F1>
" Expand tabs to 2 spaces.
set expandtab tabstop=2 shiftwidth=2
" List formats to recognise:
"  - blah blah
"  * blah blah
"  2. blah blah
set formatlistpat=^\\s*\\([-*]\\\|\\d\\+\\.\\)\\s*
if has('eval')
  " Save this so it can be restored later.
  let g:johntobin_formatlistpat = &formatlistpat
endif

" Movement through the file.
" Proper backspace, that deletes previously entered text.
set backspace=indent,eol,start
" Make the arrow keys wrap - i.e. hitting left arraw at the start of a
" line will move the cursor to the end of the previous line.
set whichwrap+=<,>,b,[,]
" Make % work with <>.
set matchpairs+=<:>
" Stop the goddamn MatchParen plugin from loading.
let loaded_matchparen = 1
" Disable the mouse, I don't like it.
set mouse=""

" Compilation related stuff.
" make should run silently from within vim to help with quickfix mode.
set makeprg+=\ -s

" Completion settings
" Dictionary file to read - Linux/*BSD, Solaris.
set dictionary+=/usr/share/dict/words,/usr/share/lib/dict/words

" History
" Keep a history of commands type in command mode (after typing ':'), and
" searches.
set history=100
if has('viminfo')
  " Default:
  "set viminfo='20,<50,s10,h
  set viminfo='100,<50,s10,h
endif

" Misc stuff, bugfixes.
" Prevent vim connecting to the X server so that using PuTTY works without
" Exceed.  This prevents cut and paste between Vim and the X server, but
" doesn't prevent cut and paste between the terminal and the X server.
" Selecting text within Vim won't copy it to the X server's clipboard, but
" selecting text from the terminal will.  You won't notice the difference
" unless you've got the mouse enabled.
if !has('nvim')
  set clipboard=exclude:.*
endif
" Don't treat numbers starting with a 0 as octal.
set nrformats-=octal
" But do support incrementing single alphabetical characters.
set nrformats+=alpha
" Enable smart tabs, to see what they do.
set smarttab
if has('multi_lang')
  language en_IE.UTF-8
endif
if has('spell')
  " Turn on spelling if available.
  set spell
endif
if exists('+spelloptions')
  " In CamelCase words recognise each sub-word.
  set spelloptions+=camel
endif
if exists('+spellfile')
  " My word to recognise will be added to this file.
  set spellfile+=~/.vim/spell/en.utf-8.add
endif

if has('user_commands') && !exists(':DiffOrig')
  " Taken from :help :DiffOrig - this should diff the current buffer against
  " the file on disk.
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif
