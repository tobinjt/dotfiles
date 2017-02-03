" vim: set filetype=vim :
if !has("autocmd")
 finish
endif
" Taken from Bram Moolenar's example vimrc:
" Jump to the previous position in the file.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ 	exe "normal g`\"" |
  \ endif
" On BSD systems, the original file provided by crontab(1) must be written to,
" rather than writing a new file and renaming it.
autocmd FileType crontab setlocal backupcopy=yes
" Auto-wrap text, autowrap comments, allow fomment formatting, don't break lines
" that are longer than textwidth when insertion starts.
autocmd FileType pod setlocal textwidth=72 formatoptions+=tcql
" Assume foo.t is Perl; Perl Modules come with tests in t/*.t
autocmd BufEnter *.t setlocal ft=perl
autocmd FileType perl call JT_populate_perl()
autocmd FileType make setlocal shiftwidth=8 tabstop=8
autocmd FileType tex setlocal textwidth=75 makeprg=make\ -s foldmethod=syntax
  \ formatoptions+=2
autocmd FileType c,cpp setlocal foldmethod=syntax

" Editing bash command lines.
autocmd BufRead,BufNewFile /tmp/bash-fc-* setlocal filetype=sh
autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
autocmd FileType python setlocal foldminlines=5 foldnestmax=3 foldmethod=indent
  \ shiftwidth=2 tabstop=2 softtabstop=2

autocmd BufRead,BufNewFile *.md,*.mkd,*.mdwn setlocal filetype=markdown
autocmd FileType markdown setlocal formatoptions+=nt formatoptions-=l
  \ formatlistpat=^\\s*\\(\\*\\\|[0-9]\\.\\)\\s\\+ comments=n:> foldmethod=expr
  \ foldexpr=MarkdownFolding(v:lnum)
" tmux(1)
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setlocal filetype=tmux
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
  \ nofoldenable spell textwidth=1000

" Turn on spelling, if the vim we're using supports it, for specific file types.
if has("spell")
  autocmd FileType html,tex,text,mail,perl,pod,c,gitcommit,markdown,debchangelog
    \ setlocal spell
  " This turns on spell checking properly.
  autocmd FileType html,text,mail,gitcommit,markdown syntax spell toplevel
  autocmd BufReadPre,BufNewFile *.txt,svn-commit.* setlocal spell
  autocmd FileType text setlocal formatoptions+=nq
  autocmd BufReadPre,BufNewFile w3mtmp* setlocal spell tw=72
  autocmd FileType help setlocal nospell
endif

autocmd FileType lisp syn keyword lispTodo contained XXX

" Try to highlight XXX in Latex source
autocmd FileType tex syn match texError "XXX"

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

" Set filetype=sshconfig for all ssh config snippets.
autocmd BufReadPost,BufNewFile */.ssh/config* set filetype=sshconfig
