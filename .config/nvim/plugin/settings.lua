-- Visual stuff.
-- Use a visual flash rather than ringing the bell.
vim.opt.visualbell = true
-- Display 8 lines of context while moving through the file.
vim.opt.scrolloff = 8
-- Highlight the current line.
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
-- Line numbers to make jumping easier.
vim.opt.number = true
vim.opt.relativenumber = true
-- Don't highlight search results afterwards.
vim.opt.hlsearch = false
-- Ignore case when searching . . . but see below
vim.opt.ignorecase = true
-- Don't ignore case if an uppercase letter was typed in the pattern.
vim.opt.smartcase = true
-- Show matching (),{} and [] as you type.
vim.opt.showmatch = true
-- Open new windows below the current window (to the right with vsplit).
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Don't redraw the screen while executing macros etc.
vim.opt.lazyredraw = true
-- Use TrueColor (24 bit).
vim.opt.termguicolors = true

-- File related stuff.
-- When tab-completing filenames, expand to the longest common substring on the
-- first tab, then move through options on the second and subsequent tabs;
-- basically behave the same as zsh does.
vim.opt.wildmode = "longest,full"
-- Ask the user if they want to save or abandon changes rather than failing.
vim.opt.confirm = true
-- Case-insensitive completion for filenames.
vim.opt.wildignorecase = true
-- Fully unload files when I close them, otherwise they can't be opened in other
-- instances.
vim.opt.hidden = false -- 'nohidden' in Vimscript is 'hidden=false' in Lua
-- Track undo information so that I can undo when I reopen a file.
vim.opt.undofile = true

-- Formatting options.
-- Automatically insert comment leaders after hitting return in Insert mode or
-- O/o in Normal mode.
vim.opt.formatoptions:append("ro")
-- Recognise lists; see formatlistpat below for accepted styles.
vim.opt.formatoptions:append("n")
vim.opt.textwidth = 80
-- Expand tabs to 2 spaces.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- List formats to recognise:
--  - blah blah
--  * blah blah
--  2. blah blah
-- Need to be careful with escaping backslashes in Lua strings.
vim.opt.formatlistpat = "^\\s*\\([-*]\\|\\d\\+\\.\\)\\s*"
-- Save this so it can be restored later.
---@diagnostic disable: undefined-field
vim.g.johntobin_formatlistpat = vim.opt.formatlistpat:get()

-- Movement through the file.
-- Make the arrow keys wrap - i.e. hitting left arrow at the start of a
-- line will move the cursor to the end of the previous line.
vim.opt.whichwrap:append("<,>,b,[,]")
-- Make % work with <>.
vim.opt.matchpairs:append("<:>")
-- Disable the mouse, I don't like it.
vim.opt.mouse = ""

-- Completion settings
-- Dictionary file to read - Linux/*BSD, Solaris.
vim.opt.dictionary:append("/usr/share/dict/words")
-- Fill in the longest common prefix first, then show a menu.
vim.opt.completeopt = "longest,menu,preview"

-- Input.
-- Support incrementing single alphabetical characters.
vim.opt.nrformats:append("alpha")
-- Timeout when reading mappings.
vim.opt.ttimeoutlen = 100

-- Spelling.
-- Turn on spelling.
vim.opt.spell = true
-- In CamelCase words recognise each sub-word.
vim.opt.spelloptions:append("camel")
-- My words to recognise will be added to this file.
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
