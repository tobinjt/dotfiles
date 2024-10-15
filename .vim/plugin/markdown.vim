" Markdown

" Simple folding of sections.
let g:MarkdownMinimumHeaderFoldingLevel = 2
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

augroup johntobin-markdown
  autocmd!

  " Automatically wrap text at textwidth.
  autocmd FileType markdown setlocal formatoptions+=t formatoptions-=l
  " Interpret blockquotes (lines starting with '>') as comments, so that line
  " wrapping doesn't mangle the blockquote markers.
  autocmd FileType markdown setlocal comments=n:>
  " Enable simple folding.
  autocmd FileType markdown setlocal foldmethod=expr
    \ foldexpr=MarkdownFolding(v:lnum)
  " Overwrite the default of 4 set by markdown syntax highlighting.
  autocmd FileType markdown setlocal shiftwidth=2
  " Set formatlistpat to my setting, overwriting the setting from
  " vim??/ftplugin/markdown.vim.
  autocmd FileType markdown call SetFormatlistpat()

augroup END
