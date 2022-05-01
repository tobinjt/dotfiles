if has('eval')
  if ! exists('g:MarkdownMinimumHeaderFoldingLevel')
    let g:MarkdownMinimumHeaderFoldingLevel = 2
  endif
  function! MarkdownFolding(lnum)
    let l:line = getline(a:lnum)
    let l:matches = matchlist(l:line, '^\(#\+\)')
    if len(l:matches) == 0
      return '='
    endif
    let l:length = strlen(l:matches[1])
    if l:length <= 1
      return '='
    endif
    return '>' . (l:length - (g:MarkdownMinimumHeaderFoldingLevel - 1))
  endfunction
endif
