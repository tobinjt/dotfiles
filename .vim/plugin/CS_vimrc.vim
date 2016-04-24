" vim: set foldmethod=marker :

if has("eval")
  if has("autocmd")
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
  endif

endif
