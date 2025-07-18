" Put most autocmds in my own custom group, as recommended by the Google Vim
" style guide.
augroup johntobin
autocmd!

  " keep-sorted start sticky_prefixes="

  autocmd BufReadPost,BufNewFile *.json setlocal filetype=javascript
  autocmd BufReadPost,BufNewFile *.tt2 setlocal filetype=tt2
  " Set filetype=sshconfig for all ssh config snippets.
  autocmd BufReadPost,BufNewFile */.ssh/config* setlocal filetype=sshconfig
  " Hugo files are go html templates, not pure html.
  autocmd BufReadPost,BufNewFile */hugo-coder/*/*.html setlocal filetype=gohtmltmpl
  autocmd BufReadPost,BufNewFile .bcrc setlocal filetype=bc
  " .coveragerc used by Python coverage is actually an ini file.
  autocmd BufReadPost,BufNewFile .coveragerc setlocal filetype=dosini
  autocmd BufReadPost,BufNewFile authorized_keys* setlocal textwidth=1000
  " On BSD systems, the original file provided by crontab(1) must be written to,
  " rather than writing a new file and renaming it.
  autocmd FileType crontab setlocal backupcopy=yes textwidth=1000
  " Stop checking for capitals at the start of a sentence.
  autocmd FileType dot setlocal spellcapcheck= textwidth=300 foldmethod=indent
  " This turns on spell checking properly.
  autocmd FileType gitcommit syntax spell toplevel
  " Set a wide textwidth because Golang tends to have wide lines and airline
  " whitespace checks use textwidth.
  autocmd FileType go setlocal textwidth=120
  " Too many distracting spelling errors and long lines.
  autocmd FileType help setlocal nospell
  " Shorter textwidth to stay within hg commit message guidelines.
  autocmd FileType hgcommit setlocal textwidth=78
  " This turns on spell checking properly.
  autocmd FileType html syntax spell toplevel
  " Javascript syntax highlighting messes with the way folds are displayed and I
  " don't like it, so set it back to the default.
  autocmd FileType javascript setlocal foldtext=foldtext()
  " Set formatlistpat to my setting, overwriting the setting from
  " vim??/ftplugin/markdown.vim.
  autocmd FileType markdown let &formatlistpat = g:johntobin_formatlistpat
  " Interpret blockquotes (lines starting with '>') as comments, so that line
  " wrapping doesn't mangle the blockquote markers.
  autocmd FileType markdown setlocal comments=n:>
  " Automatically wrap text at textwidth.
  autocmd FileType markdown setlocal formatoptions+=t formatoptions-=l
  " Overwrite the default of 4 set by markdown syntax highlighting.
  autocmd FileType markdown setlocal shiftwidth=2
  " Automatic indentation is awful, disable it.
  autocmd FileType php setlocal foldtext=foldtext() indentexpr= shiftwidth=4
  " Wider textwidth for compatibility with black.
  autocmd FileType python setlocal textwidth=88
  " This turns on spell checking properly.
  autocmd FileType text syntax spell toplevel
  " Stop checking for capitals at the start of a sentence.
  autocmd FileType tmux setlocal spellcapcheck=
  autocmd FileType tt2 setlocal commentstring=#%s
  autocmd FileType vim setlocal foldmethod=syntax
  " Resize splits when the window is resized.
  autocmd VimResized * execute "normal! \<C-w>="

  " keep-sorted end

augroup END
