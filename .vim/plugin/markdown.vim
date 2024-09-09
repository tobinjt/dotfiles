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
  " Set formatlistpat to my setting, overwriting the setting from
  " vim??/ftplugin/markdown.vim.
  autocmd FileType markdown call SetFormatlistpat()

augroup END

" vim-markdown
" Recognise ```shell as a block with sh syntax.
if !exists('g:vim_markdown_fenced_languages')
  let g:vim_markdown_fenced_languages = []
endif
let g:vim_markdown_fenced_languages += ['shell=sh']
" Don't indent new lines in lists.
let g:vim_markdown_new_list_item_indent = 0
" Disable mappings; I don't use them, and they conflict with diff mappings
" (e.g. [c, ]c).
let g:vim_markdown_no_default_key_mappings = 1
" Highlight various types of front matter as used by Hugo.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" Support strikethrough.
let g:vim_markdown_strikethrough = 1
" Disable the plugin's folding because it randomly folds and unfolds when
" editing; autocmds will use my simple folding instead.
let g:vim_markdown_folding_disabled = 1
