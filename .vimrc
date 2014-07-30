" vim: set foldmethod=marker :
" My .vimrc - an attempt to customise vim and save most of my settings so that
" I'm independant of the global vimrc wherever I go.
" $Id: .vimrc,v 1.62 2007/03/23 14:20:00 tobinjt Exp $

" Enable for debugging.
"set verbose=2

" Remove 'vcsdiff' because it overwrites Syntastic error markers.
let g:quickfixsigns_classes = ['qfl', 'loc', 'marks', 'breakpoints']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_auto_loc_list = 0
" Don't auto-install tools.
let g:go_disable_autoinstall = 1
" Stop messing with tab.
let g:UltiSnipsExpandTrigger = "<F3>"
" let g:SuperTabDefaultCompletionType = ""

" Set up Vundle.
" To update all the git submodules, run these commands:
" $ git submodule init
" $ git submodule update
" $ git submodule foreach \
"     'git fetch origin --tags && git checkout master && git pull'
" To update a single submodule, run the last line in the submodule's directory.
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'
" Add bundles here.
Plugin 'altercation/vim-colors-solarized'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Plugin 'fatih/vim-go'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/LargeFile'
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
