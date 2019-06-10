if !has("autocmd")
 finish
endif
" Taken from Bram Moolenar's example vimrc:
" Jump to the previous position in the file.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \   | exe "normal! g`\""
  \ | endif
" On BSD systems, the original file provided by crontab(1) must be written to,
" rather than writing a new file and renaming it.
autocmd FileType crontab setlocal backupcopy=yes textwidth=1000
" Auto-wrap text, autowrap comments, allow fomment formatting, don't break lines
" that are longer than textwidth when insertion starts.
autocmd FileType pod setlocal textwidth=72 formatoptions+=tcql
" Assume foo.t is Perl; Perl Modules come with tests in t/*.t
autocmd BufEnter *.t setlocal ft=perl
autocmd FileType make setlocal shiftwidth=8 tabstop=8
autocmd FileType tex setlocal textwidth=75 makeprg=make\ -s foldmethod=syntax
  \ formatoptions+=2
autocmd FileType c,cpp setlocal foldmethod=syntax

" Editing bash command lines.
autocmd BufRead,BufNewFile /tmp/bash-fc-* setlocal filetype=sh
autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
autocmd FileType python setlocal foldminlines=5 foldnestmax=3 foldmethod=indent
  \ shiftwidth=2 tabstop=2 softtabstop=2
" Javascript syntax highlighting messes with the way folds are displayed and I
" don't like it, so set it back to the default.
autocmd FileType javascript,php setlocal foldtext=foldtext()

autocmd FileType markdown setlocal formatoptions+=nt formatoptions-=l
  \ formatlistpat=^\\s*\\(\\*\\\|[0-9]\\.\\)\\s\\+ comments=n:>
" tmux(1)
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setlocal filetype=tmux
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8
  \ nofoldenable spell textwidth=1000

" Turn on spelling, if the vim we're using supports it, for specific file types.
if has("spell")
  autocmd FileType html,tex,text,mail,perl,pod,c,gitcommit,markdown,debchangelog
    \ setlocal spell
  " This turns on spell checking properly.
  autocmd FileType html,text,mail,gitcommit syntax spell toplevel
  autocmd BufReadPre,BufNewFile *.txt,svn-commit.* setlocal spell
  autocmd FileType text setlocal formatoptions+=nq
  autocmd BufReadPre,BufNewFile w3mtmp* setlocal spell tw=72
  autocmd FileType help setlocal nospell
endif

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
" Set a wide textwidth for authorized_keys.
autocmd BufReadPost,BufNewFile */.ssh/authorized_keys set textwidth=1000
autocmd BufReadPost,BufNewFile authorized_keys* set textwidth=1000
" .coveragerc used by Python coverage is actually an ini file.
autocmd BufReadPost,BufNewFile .coveragerc set filetype=dosini
autocmd BufReadPost,BufNewFile *.tt2 set filetype=tt2
autocmd FileType tt2 set commentstring=#%s

" Run dot every time the file is saved.
autocmd BufWritePost *.dot execute 'silent !dot -O -Tpdf %' | redraw!
autocmd FileType dot setlocal textwidth=200
