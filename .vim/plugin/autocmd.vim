if !has('autocmd')
 finish
endif

" Put most autocmds in my own custom group, as recommended by the Google Vim
" style guide.
augroup johntobin
autocmd!

" On BSD systems, the original file provided by crontab(1) must be written to,
" rather than writing a new file and renaming it.
autocmd FileType crontab setlocal backupcopy=yes textwidth=1000
autocmd FileType make setlocal shiftwidth=8 tabstop=8
autocmd FileType c,cpp setlocal foldmethod=syntax

autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
" Wider textwidth for compatibility with black.
autocmd FileType python setlocal textwidth=88
" Javascript syntax highlighting messes with the way folds are displayed and I
" don't like it, so set it back to the default.
autocmd FileType javascript,php setlocal foldtext=foldtext()
" Shorter textwidth to stay within hg commit message guidelines.
autocmd FileType hgcommit setlocal textwidth=78

" Markdown
" Automatically wrap text at textwidth.
autocmd FileType markdown setlocal formatoptions+=t formatoptions-=l
" Interpret blockquotes (lines starting with '>') as comments, so that line
" wrapping doesn't mangle the blockquote markers.
autocmd FileType markdown setlocal comments=n:>
" Enable simple folding.
autocmd FileType markdown setlocal foldmethod=expr
  \ foldexpr=MarkdownFolding(v:lnum)
" Set formatlistpat to my setting, overwriting the setting from
" vim82/ftplugin/markdown.vim.
autocmd FileType markdown call JT_set_formatlistpat()

" Golang
" Set a wide textwidth because Golang tends to have wide lines and airline
" whitespace checks use textwidth.
autocmd FileType go setlocal foldmethod=syntax textwidth=120 colorcolumn=
" Autoformatting Go code on write causes folds to be closed; this autocmd opens
" the fold under the cursor.
if has('eval')
  autocmd BufWritePost *.go call OpenFoldUnderCursor()
endif
" Supertab will use vim-go's omnifunc first, and if that doesn't produce results
" will fall back to vim's standard completion.
autocmd FileType go call SuperTabChain(&omnifunc, "<c-p>")

" Turn on spelling if available.
if has('spell')
  " help and some other files have too many distracting spelling errors.
  autocmd FileType help setlocal nospell
  " Checking for capitals at the start of a sentence is incorrect for some
  " files.
  autocmd FileType dot,tmux set spellcapcheck=
  " This turns on spell checking properly.
  autocmd FileType html,text,gitcommit syntax spell toplevel
endif

" Set filetype=sshconfig for all ssh config snippets.
autocmd BufReadPost,BufNewFile */.ssh/config* set filetype=sshconfig
" Set a wide textwidth for authorized_keys.
autocmd BufReadPost,BufNewFile */.ssh/authorized_keys set textwidth=1000
autocmd BufReadPost,BufNewFile authorized_keys* set textwidth=1000
" Hugo files are go html templates, not pure html.
autocmd BufReadPost,BufNewFile */hugo-coder/*/*.html set filetype=gohtmltmpl
" .coveragerc used by Python coverage is actually an ini file.
autocmd BufReadPost,BufNewFile .coveragerc set filetype=dosini
autocmd BufReadPost,BufNewFile *.tt2 set filetype=tt2
autocmd FileType dosini,tt2 set commentstring=#%s
autocmd BufReadPost,BufNewFile .bcrc set filetype=bc
autocmd FileType dot setlocal textwidth=300 foldmethod=indent

if has('eval') && PluginLoaded('vim-lsp')
  autocmd BufReadPost * call DisableLSPForBufferWhenThereAreConflictMarkers()
  autocmd BufWritePost * call ReenableLSPForBufferWhenThereWereConflictMarkers()
  autocmd BufWritePre *.rs LspDocumentFormatSync
endif

augroup END

" Highlight the first three characters over the line length limit.  Clearing the
" highlight group first makes the background the same colour, so we only see
" this once we actually exceed the limit.
"
" (Note: we have to use autocommands for the highlighting since :colorscheme can
" overwrite this highlighting, and :colorscheme apparently gets applied after
" the .vimrc is done sourcing.)
if exists('+colorcolumn')
  set colorcolumn=+1,+2,+3
  augroup color_tweak
    autocmd!
    autocmd ColorScheme * highlight clear ColorColumn
    autocmd ColorScheme * highlight ColorColumn guifg=red ctermfg=red gui=bold
  augroup END
endif
