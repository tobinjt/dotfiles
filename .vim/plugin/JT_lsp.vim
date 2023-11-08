" Config for https://github.com/prabirshrestha/vim-lsp
" https://github.com/mattn/vim-lsp-settings configures language servers.

if ! PluginLoaded('vim-lsp')
  finish
endif

augroup johntobin-lsp
autocmd!

" Copied from https://github.com/prabirshrestha/vim-lsp#registering-servers
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif
endfunction
" Call s:on_lsp_buffer_enabled only for languages with registered servers.
autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

augroup END
