" Vim syntax file
" Language:     Any
" Last Change:  11 March 2008
" Filenames:    none
" Maintainar:   John Tobin <tobinjt@cs.tcd.ie>
" Version:      0.1
" Summary:      Spell check comments.
" Description:  Spell check comments (lines starting with a #), but not other lines.
" Installation: Put this file in ~/.vim/syntax

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "spell_check_comment"
runtime JT_functions
call Spell_check_comments()
