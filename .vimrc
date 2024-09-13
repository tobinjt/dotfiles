" My .vimrc - an attempt to customise vim and save most of my settings so that
" I'm independent of the global vimrc wherever I go.

" Load vim defaults.
if !has('nvim')
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

" ALE
" Autofix if available.
let g:ale_fix_on_save = 1
" Automatically fix Typescript.
let g:ale_fixers = {
  \  'typescript': [
  \    'eslint',
  \  ],
  \}
" Recognise the global variables Neovim provides.
let g:ale_lua_luacheck_options = '--globals vim'

" Supertab
" Use more clever completion.
let g:SuperTabDefaultCompletionType = 'context'

" Rust
" Enable folding.
let g:rust_fold = 1
" Autoformat on save: rust.vim's autoformat is really slow, search for
" Rust in plugin/JT_autocmd.vim for how I've implemented autoformat.
let g:rustfmt_autosave = 0
" Use `cargo clippy` rather than `cargo check` when available.
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
" Run cargo on tests too.
let g:rust_cargo_check_tests = 1

" Plugins.
" To update all the git submodules: update-dotfiles-and-bin-plugins
" To update a single submodule:
"   $ git fetch origin --tags && git checkout master && git pull
" To add a new submodule:
"   $ git submodule add URL DESTINATION
"   $ git submodule add \
"       https://github.com/junegunn/vim-plug.git .vim/bundle/vim-plug
"   Add a "Plug 'foo/bar'" line below and commit the changes.
"   $ update-dotfiles-and-bin
" To remove a submodule:
"   $ DESTINATION=".vim/bundle/asdf"
"   $ git rm "${DESTINATION}" && rm -rf ".git/modules/${DESTINATION}"
"   Remove any config for the plugin.
"   Remove the "Plug 'foo/bar'" line below and commit the changes.
"   $ update-dotfiles-and-bin
"   It will complain about files left behind, copy and paste the commands to
"   clean up.
" To use a branch other than master:
"   $ git submodule set-branch --branch BRANCH SUBMODULE_PATH
"   $ git submodule set-branch --branch main .vim/bundle/vim-plug
"   $ git diff # Should show a branch line added in .gitmodules
"   # The branch in the submodule will look like `(HEAD detached at a53e340)`
"   # but it appears to work properly.

" Initialise vim-plug.
call plug#begin('~/.vim/bundle')
" Add bundles here.
" keep-sorted start sticky_prefixes="
" Run lint and other tools on the fly.
Plug 'dense-analysis/ale'
" Tab completion.
Plug 'ervandew/supertab'
" Golang support.
Plug 'fatih/vim-go'
" Plugin management.
Plug 'junegunn/vim-plug'
" Puts marks in the sign column.
Plug 'kshenoy/vim-signature'
" Solarized colour scheme.
Plug 'lifepillar/vim-solarized8'
" Puts VCS info in the signs column.
Plug 'mhinz/vim-signify'
" Language Server Protocol support.
Plug 'prabirshrestha/vim-lsp'
" Configures ALE and vim-lsp to work together.
Plug 'rhysd/vim-lsp-ale'
" Better folding of Python.
Plug 'tmhedberg/SimpylFold'
" Markdown syntax highlighting.
Plug 'tobinjt/vim-markdown'
" Easy wrapping of comment blocks with \wc.
Plug 'tobinjt/wrap-comment-block.vim'
" Easy commenting and uncommenting.
Plug 'tpope/vim-commentary'
" Improved status bar.
Plug 'vim-airline/vim-airline'
" Turn off various things when editing really large files.
Plug 'vim-scripts/LargeFile'
" Makes filename:line-number[:column] work.
Plug 'wsdjeg/vim-fetch'
" keep-sorted end
" Must be loaded after prabirshrestha/vim-lsp is loaded.
Plug 'mattn/vim-lsp-settings'

" This needs to be done before loading plugins, so that runtimepath can be
" extended first.
let b:local_filename=expand('~/.vim/local.vim')
if filereadable(b:local_filename)
  exec 'source ' . b:local_filename
endif

" Finish vim-plug setup.
call plug#end()

" All plugins have now been loaded and their functionality is available.

" Explicitly put ~/.vim first, because vim will put spelling additions in the
" first directory in runtimepath.  Overwrite runtimepath rather than adding to
" it because additions are placed at the end.
set runtimepath-=~/.vim
set runtimepath^=~/.vim

colorscheme solarized8-mine
