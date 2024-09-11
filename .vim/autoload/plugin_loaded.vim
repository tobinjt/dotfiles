function! plugin_loaded#plugin_loaded(plugin) abort
  " Use / and , to ensure vim-lsp doesn't match vim-lsp-settings.
  return stridx(&runtimepath, '/' . a:plugin . ',') >= 0
endfunction
