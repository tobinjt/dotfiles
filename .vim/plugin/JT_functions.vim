" vim: set filetype=vim :
if has("eval")
    function! Spell_check_comments()
        syntax match    spell_check_comment /^[[:space:]]*#.*/ contains=@Spell
        hi def link     spell_check_comment Comment
    endfunction
    function! AddPeriods()
        g/^-/s/[^.:]\zs$/./
    endfunction
    " Return the name of the syntax highlighting group under the cursor.
    function! SyntaxUnderCursor()
        echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')
    endfunction

    " Initialise now so it always exists.
    let s:last_search = ''
    function! Grep(pattern)
        let s:last_search = a:pattern
        call ReGrep()
    endfunction
    function! ReGrep()
        " This can't work if there wasn't a previous search.
        if s:last_search == ''
            return
        endif
        let l:pattern = '/' . escape(s:last_search, '/') . '/j'
        let l:path = expand('%:h')
        " Handle there not being a filename; we don't want to start searching
        " from /.
        if l:path == ''
            let l:path = getcwd()
        endif
        let l:path = l:path . '/**'
        execute 'lvimgrep ' . l:pattern . ' ' . l:path
        lwindow
    endfunction
endif
