" Rust
" Enable syntax-based folding for vim, use treesitter folding for nvim.
if !has('nvim')
  let g:rust_fold = 1
endif
" Autoformat on save: rust.vim's autoformat is really slow, search for
" LspDocumentFormatSync in plugin/lsp.vim for how I've implemented autoformat.
let g:rustfmt_autosave = 0
" Run cargo on tests too.
let g:rust_cargo_check_tests = 1
