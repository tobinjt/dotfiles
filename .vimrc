" vim: set foldmethod=marker :
" My .vimrc - an attempt to customise vim and save most of my settings so that
" I'm independant of the global vimrc wherever I go.
" $Id: .vimrc,v 1.62 2007/03/23 14:20:00 tobinjt Exp $

" Enable for debugging.
"set verbose=2

" Remove 'vcsdiff' because it overwrites Syntastic error markers.
let g:quickfixsigns_classes = ['qfl', 'loc', 'marks', 'breakpoints']

" Syntastic.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Don't use the go binary, it complains about packages.
" go get -u github.com/golang/lint/golint
" go get -u golang.org/x/tools/cmd/gotype
" All of these will be run serially; remove if that gets too slow.
let g:syntastic_go_checkers = ['gofmt', 'golint', 'gotype', 'govet']
"let g:syntastic_auto_loc_list = 0

" vim-go.
" Don't auto-install tools.
let g:go_disable_autoinstall = 1
" Use goimports, it should fix up import lines automatically.
let g:go_fmt_command = "goimports"
" More highlighting.
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Change the trigger so it doesn't clash with SuperTab; this means I have to
" explicitly trigger snippet expansion and it doesn't happen accidentally.
let g:UltiSnipsExpandTrigger = "<C-N>"
let g:UltiSnipsListSnippets = "<F3>"

" Set up Vundle.
" To update all the git submodules, run these commands:
" $ git submodule init
" $ git submodule update
" $ git submodule foreach \
"     'git fetch origin --tags && git checkout master && git pull'
" To update a single submodule, run the last line in the submodule's directory.
" To add a new submodule run:
" $ git submodule add URL DESTINATION
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'
" Add bundles here.
Plugin 'ConradIrwin/vim-bracketed-paste'
if v:version >= 704
  Plugin 'SirVer/ultisnips'
endif
Plugin 'altercation/vim-colors-solarized'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-scriptease.git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/LargeFile'
Plugin 'vim-scripts/argtextobj'
Plugin 'vim-scripts/file-line'
Plugin 'vim-scripts/quickfixsigns'

" This needs to be done before loading plugins, so that runtimepath can be
" extended first.
if has("eval")
  let b:local_filename=expand('~/.vim/local.vim')
  if filereadable(b:local_filename)
    exec 'source ' . b:local_filename
  endif
endif

" Explicitly put ~/.vim first, because vim will put spelling additions in the
" first directory in runtimepath.
set runtimepath-=~/.vim
exec 'set runtimepath=~/.vim,' . &runtimepath
filetype plugin indent on
syntax on
