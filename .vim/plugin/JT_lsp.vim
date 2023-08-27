" Config for https://github.com/prabirshrestha/vim-lsp

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

if executable('pylsp')
  " pip install python-lsp-server
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'pylsp',
    \ 'cmd': {server_info->['pylsp']},
    \ 'allowlist': ['python'],
    \ })
endif

augroup END
