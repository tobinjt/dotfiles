" vim: set filetype=vim :
if !has("autocmd")
 finish
endif
" On BSD systems, the original file provided by crontab(1) must be written to,
" rather than writing a new file and renaming it.
autocmd FileType crontab setlocal backupcopy=yes
autocmd FileType pod setlocal textwidth=72
autocmd FileType make setlocal shiftwidth=8 tabstop=8
autocmd FileType tex setlocal textwidth=75 makeprg=make\ -s foldmethod=syntax formatoptions+=2
" Don't scan included files when completing, it's too slow.
autocmd FileType c,cpp setlocal foldmethod=syntax complete-=i
autocmd FileType cpp,html setlocal matchpairs+=<:>

" Editing bash command lines.
autocmd BufRead,BufNewFile /tmp/bash-fc-* setlocal filetype=sh
autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
autocmd FileType python setlocal foldminlines=5 foldnestmax=3 foldmethod=indent shiftwidth=2 tabstop=2 softtabstop=2
function! JT_install_maps()
   noremap <buffer> <F2> gqap
  inoremap <buffer> <F2> <C-O>gwap
  vnoremap <buffer> <F2> gq
endfunction

autocmd BufRead,BufNewFile *.mkd,*.mdwn setlocal filetype=markdown
autocmd FileType markdown setlocal formatoptions+=nt formatoptions-=l formatlistpat=^\\s*\\(\\*\\\|[0-9]\\.\\)\\s\\+ comments=n:> foldmethod=expr foldexpr=MarkdownFolding(v:lnum)
autocmd BufRead,BufNewFile *.twiki setlocal filetype=twiki
autocmd FileType twiki setlocal textwidth=1000
" tmux(1)
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setlocal filetype=tmux
autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8 foldmethod=syntax spell textwidth=1000

" Turn on spelling, if the vim we're using supports it, for specific file types.
if has("spell")
  autocmd FileType html,tex,text,mail,perl,pod,c,gitcommit,markdown,debchangelog setlocal spell
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

" Highlight trailing whitespace, but not when typing.
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight link ExtraWhitespace Error
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if has("eval")
  autocmd BufNewFile,BufReadPre * call JT_install_maps()
endif

" *.t: Perl test scripts.
if has("eval")
  autocmd BufNewFile *.t call CS_populate_perl()
endif
