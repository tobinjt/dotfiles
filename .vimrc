" My .vimrc - an attempt to customise vim and save most of my settings so that
" I'm independent of the global vimrc wherever I go.

" Enable for debugging.
"set verbose=2

" Load vim defaults.
if !has('nvim')
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

" Don't save netrw history, I don't use it.
let g:netrw_dirhistmax = 0

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

" Nerdcommenter
" Add spaces between delimiters and line contents.
let g:NERDSpaceDelims = 1

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

" Syntastic.  I've removed Syntastic, I'm keeping this for now so that I can
" more easily reconfigure ALE if necessary.
" --- Configure Go checkers.
" Install the necessary tools with; $ install-extra-tools-for-vim
" All of these will be run serially; remove if that gets too slow.
let g:syntastic_go_checkers =
      \ ['go', 'gofmt', 'golangci_lint', 'gotype', 'govet']
" --- Configure Javascript checkers.
let g:syntastic_javascript_checkers =
      \ ['closurecompiler', 'eslint', 'gjslint', 'glint']
if executable('/usr/local/bin/closure-compiler')
  let g:syntastic_javascript_closurecompiler_script =
        \ '/usr/local/bin/closure-compiler'
else
  let g:syntastic_javascript_closurecompiler_script =
        \ '/usr/bin/closure-compiler'
endif
let g:syntastic_typescript_checkers = ['eslint']
" --- Configure markdown checkers.
" Use markdownlint for the mdl linter.
let g:syntastic_markdown_mdl_exec = 'markdownlint'
let g:syntastic_markdown_mdl_args = ''
" --- Configure Python checkers.
" Make sure that python3 is used so it can parse type annotations.
let g:syntastic_python_python_exec = 'python3'
" Add mypy to the list of Python checkers.
let g:syntastic_python_checkers = ['python', 'mypy', 'pylint']
" --- Configure PHP checkers.
let g:syntastic_php_checkers = ['php', 'phplint', 'phpstan']
let g:syntastic_php_phplint_args = '--modules-path ../phplint-modules'
let g:syntastic_php_phplint_args .= ' --no-ascii-ext-check'
" Use the level defined in phpstan.neon.
let g:syntastic_php_phpstan_args = []

" vim-go.
" Install the necessary tools with; $ install-extra-tools-for-vim
" Use goimports, it should fix up import lines automatically.
let g:go_fmt_command = 'goimports'
" More highlighting.
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_debug_mappings = {
  \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
  \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
  \ '(go-debug-step)': {'key': 's'},
\}

" vim-markdown
" Recognise ```shell as a block with sh syntax.
let g:vim_markdown_fenced_languages = ['shell=sh']
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

" LSP
" Disable diagnostics, they are really intrusive.
let g:lsp_diagnostics_enabled = 0

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

function! PluginLoaded(plugin)
  return stridx(&runtimepath, a:plugin) >= 0
endfunction

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
" Reload files when changing Tmux panes.
Plug 'tmux-plugins/vim-tmux-focus-events'
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
if has('eval')
  let b:local_filename=expand('~/.vim/local.vim')
  if filereadable(b:local_filename)
    exec 'source ' . b:local_filename
  endif
endif

" Finish vim-plug setup.
call plug#end()

" All plugins have now been loaded and their functionality is available.

" Explicitly put ~/.vim first, because vim will put spelling additions in the
" first directory in runtimepath.  Overwrite runtimepath rather than adding to
" it because additions are placed at the end.
set runtimepath-=~/.vim
set runtimepath^=~/.vim
