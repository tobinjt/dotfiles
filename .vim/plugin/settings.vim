" Visual stuff.
" Use a visual flash rather than ringing the bell.
set visualbell
" Display 8 lines of context while moving through the file.
set scrolloff=8
" Highlight the current line.
set cursorline
set cursorlineopt=number
" Line numbers to make jumping easier.
set number relativenumber
" Don't highlight search results afterwards.
set nohlsearch
" Ignore case when searching . . . but see below
set ignorecase
" Don't ignore case if an uppercase letter was typed in the pattern.
set smartcase
" Show matching (),{} and [] as you type.
set showmatch
" Open new windows below the current window (to the right with vsplit).
set splitbelow splitright
" Don't redraw the screen while executing macros etc.
set lazyredraw
" Use TrueColor (24 bit).
set termguicolors

" File related stuff.
" When tab-completing filenames, expand to the longest common substring on the
" first tab, then move through options on the second and subsequent tabs;
" basically behave the same as zsh does.
set wildmode=longest,full
" Ask the user if they want to save or abandon changes rather than failing.
set confirm
" Case-insensitive completion for filenames.
set wildignorecase
" Fully unload files when I close them, otherwise they can't be opened in other
" instances.
set nohidden
" Track undo information so that I can undo when I reopen a file.
set undofile

" Formatting options.
" Automatically insert comment leaders after hitting return in Insert mode or
" O/o in Normal mode.
set formatoptions+=ro
" Recognise lists; see formatlistpat below for accepted styles.
set formatoptions+=n
set textwidth=80
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
" Make the arrow keys wrap - i.e. hitting left arrow at the start of a
" line will move the cursor to the end of the previous line.
set whichwrap+=<,>,b,[,]
" Make % work with <>.
set matchpairs+=<:>
" Disable the mouse, I don't like it.
set mouse=""

" Completion settings
" Dictionary file to read - Linux/*BSD, Solaris.
set dictionary+=/usr/share/dict/words
" Fill in the longest common prefix first, then show a menu.
set completeopt=longest,menu,preview

" Input.
" Support incrementing single alphabetical characters.
set nrformats+=alpha
" Timeout when reading mappings.
set ttimeoutlen=100

" Spelling.
" Turn on spelling.
set spell
" In CamelCase words recognise each sub-word.
set spelloptions+=camel
" My word to recognise will be added to this file.
set spellfile=~/.config/nvim/spell/en.utf-8.add
