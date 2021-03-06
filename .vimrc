" My .vimrc - an attempt to customise vim and save most of my settings so that
" I'm independant of the global vimrc wherever I go.

" Enable for debugging.
"set verbose=2

" Load vim defaults.
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Don't save netrw history, I don't use it.
let g:netrw_dirhistmax = 0

" Remove 'vcsdiff' because it overwrites Syntastic error markers.
let g:quickfixsigns_classes = ['qfl', 'loc', 'marks', 'breakpoints']

" Syntastic.
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Always update the location list, because otherwise the error window is out of
" date.
let g:syntastic_always_populate_loc_list = 1
" Configure Go checkers.
" Install the necessary tools with; $ install-extra-tools-for-vim
" All of these will be run serially; remove if that gets too slow.
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint', 'gotype', 'govet']
" Configure Javascript checkers.
let g:syntastic_javascript_checkers = ['closurecompiler', 'gjslint', 'glint']
if executable('/usr/local/bin/closure-compiler')
  let g:syntastic_javascript_closurecompiler_script =
        \ '/usr/local/bin/closure-compiler'
else
  let g:syntastic_javascript_closurecompiler_script =
        \ '/usr/bin/closure-compiler'
endif
" Make sure that python3 is used so it can parse type annotations.
let g:syntastic_python_python_exec = 'python3'
" Add mypy to the list of Python checkers.
let g:syntastic_python_checkers = ['python', 'mypy', 'pylint']
" Add phplint to the list of PHP checkers.
let g:syntastic_php_checkers = ['php', 'phplint']
let g:syntastic_php_phplint_args = '--modules-path ../phplint-modules'
let g:syntastic_php_phplint_args .= ' --no-ascii-ext-check'

" vim-go.
" Install the necessary tools with; $ install-extra-tools-for-vim
" Use goimports, it should fix up import lines automatically.
let g:go_fmt_command = "goimports"
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

" Change the trigger so it doesn't clash with SuperTab; this means I have to
" explicitly trigger snippet expansion and it doesn't happen accidentally.
let g:UltiSnipsExpandTrigger = "<C-N>"
" AFAIK there isn't a way to list the snippets for a filetype - I have to read
" the definitions.  This should list the possible snippets for the word I have
" just typed, I think.
let g:UltiSnipsListSnippets = "<F3>"

" vim-markdown
" Recognise ```shell as a block with sh syntax.
let g:vim_markdown_fenced_languages = ['shell=sh']
" Don't indent new lines in lists.
let g:vim_markdown_new_list_item_indent = 0
" Disable mappings; I don't use them, and they conflict with diff mappings (e.g.
" [c, ]c).
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

" Plugins.
" To update all the git submodules: update-vim-plugins
" To update a single submodule:
"   $ git fetch origin --tags && git checkout master && git pull
" To add a new submodule:
"   $ git submodule add URL DESTINATION
"   $ git submodule add \
"       https://github.com/junegunn/vim-plug.git .vim/bundle/vim-plug
"   Add a "Plug 'foo/bar'" line below and commit the changes.
"   $ update-dotfiles-and-bin
" To remove a submodule:
"   $ git rm DESTINATION
"   $ git rm .vim/bundle/vim-plug
"   Remove any config for the plugin.
"   Remove the "Plug 'foo/bar'" line below and commit the changes.
"   $ update-dotfiles-and-bin
"   It will complain about files left behind, copy and paste the commands to
"   clean up.
" To use a branch other than master:
"   $ git submodule set-branch --branch BRANCH SUBMODULE_PATH
"   $ git submodule set-branch --branch main .vim/bundle/yapf
"   $ git diff # Should show a branch line added in .gitmodules
"   # The branch in the submodule will look like `(HEAD detached at a53e340)`
"   # but it appears to work properly.

" Initialise vim-plug.
call plug#begin('~/.vim/bundle')
" Add bundles here.
Plug 'ConradIrwin/vim-bracketed-paste'
if has("python3")
  Plug 'SirVer/ultisnips'
endif
Plug 'cespare/vim-toml'
Plug 'ervandew/supertab'
if has('patch-8.0.1453')
  Plug 'fatih/vim-go'
endif
Plug 'godlygeek/tabular'
Plug 'google/yapf', { 'rtp': 'plugins/vim' }
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-plug'
Plug 'kshenoy/vim-signature'
Plug 'lifepillar/vim-solarized8'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tmhedberg/SimpylFold'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/LargeFile'
Plug 'vim-scripts/file-line'
Plug 'wellle/targets.vim'

" This needs to be done before loading plugins, so that runtimepath can be
" extended first.
if has("eval")
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
exec 'set runtimepath=~/.vim,' . &runtimepath
