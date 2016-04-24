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

" Syntax highlighting related settings. {{{1
if has("eval")
  " Shell scripts {{{1

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
