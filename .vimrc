" Reading .vimrc is step 3 in :help startup.
" Load vim defaults.
source $VIMRUNTIME/defaults.vim

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
" Golang support.
Plug 'fatih/vim-go'
" Plugin management.
Plug 'junegunn/vim-plug'
" Tab completion.
Plug 'lifepillar/vim-mucomplete'
" Solarized colour scheme.
Plug 'lifepillar/vim-solarized8'
" Puts VCS info in the signs column.
Plug 'mhinz/vim-signify'
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

" This needs to be done before loading plugins, so that runtimepath can be
" extended first.
let b:local_filename=expand('~/.vim/local.vim')
if filereadable(b:local_filename)
  exec 'source ' . b:local_filename
endif

" Finish vim-plug setup.
call plug#end()

" Plugins have been added to &runtimepath, and next is step 4 in :help startup:
" loading plugins.  ~/.vim should be the first entry in &runtimepath so that
" config from ~/.vim/plugin can influence plugins loaded later.

colorscheme solarized8-mine
