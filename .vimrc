" vim: set foldmethod=marker :
" My .vimrc - an attempt to customise vim and save most of my settings so that
" I'm independant of the global vimrc wherever I go.
" $Id: .vimrc,v 1.62 2007/03/23 14:20:00 tobinjt Exp $

" Enable for debugging.
"set verbose=2

" Set up Vundle.
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/gmarik/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" Add bundles here.
" TODO(johntobin): Why do I disable and reenable syntax highlighting in
" CS_vimrc?  What breaks without it?
filetype plugin indent on

" This needs to be done before loading plugins, so that runtimepath can be
" extended first.
if has("eval")
  let b:local_filename=expand('~/.vim/local.vim')
  if filereadable(b:local_filename)
    exec 'source ' . b:local_filename
  endif
endif
