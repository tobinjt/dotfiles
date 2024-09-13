" Rust
" Enable folding.
let g:rust_fold = 1
" Autoformat on save: rust.vim's autoformat is really slow, search for
" LspDocumentFormatSync in plugin/lsp.vim for how I've implemented autoformat.
let g:rustfmt_autosave = 0
" Use `cargo clippy` rather than `cargo check` when available.
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
" Run cargo on tests too.
let g:rust_cargo_check_tests = 1
