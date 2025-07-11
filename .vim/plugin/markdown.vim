" Markdown

augroup johntobin-markdown
  autocmd!

  " Automatically wrap text at textwidth.
  autocmd FileType markdown setlocal formatoptions+=t formatoptions-=l
  " Interpret blockquotes (lines starting with '>') as comments, so that line
  " wrapping doesn't mangle the blockquote markers.
  autocmd FileType markdown setlocal comments=n:>
  " Overwrite the default of 4 set by markdown syntax highlighting.
  autocmd FileType markdown setlocal shiftwidth=2
  " Set formatlistpat to my setting, overwriting the setting from
  " vim??/ftplugin/markdown.vim.
  autocmd FileType markdown call SetFormatlistpat()

augroup END
