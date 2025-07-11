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
set cursorlineopt=number
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
" Use TrueColor (24 bit).
set termguicolors
" I always have a dark background in my terminal.
set background=dark

" File related stuff.
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
" Case-insensitive completion for filenames.
set wildignorecase
" Fully unload files when I close them, otherwise they can't be opened in other
" instances.
set nohidden
" Track undo information so that I can undo when I reopen a file.
set undofile

" Move tempfiles to ~/tmp/vim.
call MoveTempFilesToTmp()

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
" Expand tabs to 2 spaces.
set expandtab tabstop=2 shiftwidth=2
" List formats to recognise:
"  - blah blah
"  * blah blah
"  2. blah blah
set formatlistpat=^\\s*\\([-*]\\\|\\d\\+\\.\\)\\s*
" Save this so it can be restored later.
let g:johntobin_formatlistpat = &formatlistpat

" Movement through the file.
" Proper backspace, that deletes previously entered text.
set backspace=indent,eol,start
" Make the arrow keys wrap - i.e. hitting left arrow at the start of a
" line will move the cursor to the end of the previous line.
set whichwrap+=<,>,b,[,]
" Make % work with <>.
set matchpairs+=<:>
" Disable the mouse, I don't like it.
set mouse=""

" Compilation related stuff.
" make should run silently from within vim to help with quickfix mode.
set makeprg+=\ -s

" Completion settings
" Dictionary file to read - Linux/*BSD, Solaris.
set dictionary+=/usr/share/dict/words
" Fill in the longest common prefix first, then show a menu.
set completeopt=longest,menu,preview

" Misc stuff, bugfixes.
" Don't treat numbers starting with a 0 as octal.
set nrformats-=octal
" But do support incrementing single alphabetical characters.
set nrformats+=alpha
" Tab at the start of a line inserts spaces.  Delete at the start of a line
" deletes as `shiftwidth` worth of spaces.  I think this also applies to
" whitespace after comments?
set smarttab
" Turn on spelling.
set spell
" In CamelCase words recognise each sub-word.
set spelloptions+=camel
" My word to recognise will be added to this file.
set spellfile=~/.vim/spell/en.utf-8.add
" Timeout when reading mappings.
set ttimeout
set ttimeoutlen=100
