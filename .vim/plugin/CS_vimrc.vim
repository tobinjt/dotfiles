" vim: set foldmethod=marker :
" Global vimrc for CS machines.

" Major settings first. {{{1

" Avoid parsing this file a second time.
if exists("g:read_CS_vimrc")
    finish
endif
if has("eval")
    let g:read_CS_vimrc = 1
endif

" Don't be Vi compatible; things have moved on since 1980.  Users with ~/.vimrc
" won't be compatible anyway, but they shouldn't need one for Vim to work
" nicely.
set nocompatible

" Enable for debugging.
"set verbose=


" Visual stuff. {{{1
" Use a visual flash rather than ringing the bell - should make life in LG8
" much more pleasant.
set visualbell
" Display 5 lines of context while moving through the file.
set scrolloff=5
" Show the position within the file in the status bar.
set ruler
" Don't highlight search results afterwards.
set nohlsearch
" Search as you type the search string.  Remember to hit return!
set incsearch
" Ignore case when searching . . . but see below
set ignorecase
" Don't ignore case if an uppercase letter was type in the pattern.
set smartcase
" Show matching (),{} and [] as you type.
set showmatch
" Show commands as you type.
set showcmd
" Open new windows below the current window (to the right with vsplit).
set splitbelow splitright

" File related stuff. {{{1
" Ignore files with these suffixes when doing tab completion.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" When tab-completing filenames, expand to the longest common substring on the
" first tab, then show a list on the second tab; basically behave the same as
" bash does.
set wildmode=longest,list
" Don't make backup copies of files.
set nobackup
" Ask the user if they want to save or abandon changes rather than failing.
set confirm

" Formatting options. {{{1
" Automatically insert comment leaders after hitting return in Insert mode or
" O/o in Normal mode.
set formatoptions+=ro
set textwidth=80
" Turn on automatic indenting.
set autoindent

" Movement through the file. {{{1
" Proper backspace, that deletes previously entered text.
set backspace=indent,eol,start
" Make the arrow keys wrap - i.e. hitting left arraw at the start of a
" line will move the cursor to the end of the previous line.
set whichwrap+=<,>,b,[,]

" Compilation related stuff. {{{1
" make should run silently from within vim to help with quickfix mode.
set makeprg+=\ -s

" Completion settings
" Dictionary file to read - Linux/*BSD, Solaris.
set dictionary+=/usr/share/dict/words,/usr/share/lib/dict/words

" History {{{1
" Keep a history of commands type in command mode (after typing ':'), and
" searches.
set history=100
if has("+viminfo")
    " Default:
    "set viminfo='20,<50,s10,h
    set viminfo='100,<50,s10,h
endif
" Misc stuff, bugfixes. {{{1
" Enable the mouse.  The _appears_ to break cut'n'paste - you need to use
" Shift-Click instead of Click, so I'll leave it disabled.
"set mouse=a
" Prevent vim connecting to the X server so that using PuTTY works without
" exceed.  This prevents cut and paste between Vim and the X server, but
" doesn't prevent cut and paste between the terminal and the X server.
" Selecting text within Vim won't copy it to the X server's clipboard, but
" selecting text from the terminal will.  You won't notice the difference
" unless you've got the mouse enabled.
set clipboard=exclude:.*
" Don't treat numbers starting with a 0 as octal.
set nrformats-=octal
" But do support incrementing single alphabetical characters.
set nrformats+=alpha

" Syntax highlighting related settings. {{{1
if has("eval")
    " We turn off syntax highlighting here so our modifications below affect it.
    syntax off
    " Shell scripts {{{1
    " Assume shell scripts are really using bash, so that we get bash-enhanced
    " syntax.
    let is_bash = 1
    " Ditto.
    let bash_is_sh = 1
    " Shell scripts: highlight quotes within quotes.
    let highlight_balanced_quotes = 1
    " Shell scripts: highlight function names in declarations.
    let highlight_function_name = 1

    " C source/headers: highlight strings and numbers withing comments. {{{1
    " Does this cause problems with PHP?  The highlighting can be a bit broken
    " sometimes, enable this with care.  It looks nice though :)
    let c_comment_strings = 1
    " C source/headers: highlight gcc specific things.
    let c_gnu = 1

    " Assembly language: we only use MC68k, so switch highlighting to that.
    let asmsyntax = "asm68k"

    " Perl settings: {{{1
    " Highlight POD within Perl source.  see perldoc perlpod
    let perl_include_pod = 1
    " Parse Perl's more complicated variables (needed for 6.x)
    let perl_extended_vars = 1
    " Highlight qq etc as statements rather than strings.
    let perl_string_as_statement = 1
    " Increase the number of lines vim looks at when highlighting Perl.
    let perl_sync_dist = 500
    " Enable folding of Perl subs; collapse subs down to a single line.  I won't
    " enable this because no one's going to know how to expand the folds.  If
    " you're interested: zo will open the fold, zc will close it.
    "let perl_fold = 1
    "let perl_fold_blocks = 1
    "let perl_nofold_packages = 1

    " PHP settings: {{{1
    " Highlight SQL queries inside strings.
    let php_sql_query = 1
    " Highlight basic PHP functions.
    let php_baselib = 1
    " Highlight HTML within strings.
    let php_htmlInStrings = 1
    " Don't highlight <? as valid start-of-PHP tags; people should use <?php
    let php_noShortTags = 1
    " Highlight ()[] related errors.
    " I'm honestly not sure what these do.
    let php_parent_error_close = 1
    let php_parent_error_open = 1
    " PHP folding - see Perl folding for details.
    "let php_folding = 1

    " Java settings. {{{1
    " Highlight basic Java identifiers.
    let java_highlight_java_lang_ids = 1
    " If you follow the braindead Java style guidelines, this will identify
    " functions.
    let java_highlight_functions="style"
    " Java's printing is apparently only for debugging, so highlight it
    " differently.
    let java_highlight_debug=1
    " Increase the number of lines used for synchronising.
    let java_minlines = 100

    " Python settings. {{{1
    " Turn on the maximum amount of highlighting.
    let python_highlight_all = 1

    " Haskell {{{1
    " Highlight True and False 
    let hs_highlight_boolean = 1
    " Highlight types
    let hs_highlight_types = 1
    let hs_highlight_more_types = 1
    let hs_highlight_debug = 1
    let hs_minlines = 100

    " Eiffel {{{1
    " Strict syntax checks
    let eiffel_strict=1
    let eiffel_pedantic=1

    " Readline {{{1
    " Add bash specific stuff
    let readline_has_bash = 1

    " Go {{{1
    " Disable Go's trailing space highlighting, mine is better because it
    " ignores the current line.
    let go_highlight_trailing_whitespace_error = 0

    " Autocommands {{{1
    " Setting up autocommands; these are actions which will be automatically taken
    " at various times.
    if has("autocmd")
        " Taken from Bram Moolenar's example vimrc:
        " Jump to the previous position in the file.
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ 	exe "normal g`\"" |
            \ endif
        " current filetype.
        " Assume foo.rev is a Bind zone file.
        autocmd BufEnter *.rev setlocal filetype=bindzone
        " Turn on cindent for PHP and Jave, so we get smart indenting of code.
        " This mightn't be necessary now that we're using filetype indent on, but I
        " dunno.
        autocmd FileType php,java setlocal cindent
        " I don't know if this does anything, now that there's specific indentation
        " for Perl (:help indent-expression).  Leave it for now, in case we're using
        " old Perl syntax highlighting somewhere.
        " Turn on cindent for Perl, but with a simple change: lines starting with a #
        " are preprocessor directives in C and should start in column 1, but in Perl
        " they're comments.  Stop Vim moving Perl comments to column 1:
        autocmd FileType perl setlocal cindent cinkeys-=#
        " Assume foo.t is Perl; Perl Modules come with tests in t/*.t
        autocmd BufEnter *.t setlocal ft=perl
        " Set the format options to do something groovy:
        " Auto-wrap text, autowrap comments, allow fomment formatting, don't break
        " lines that are longer than textwidth when insertion starts.
        " :help fo-table for more details.
        autocmd FileType pod setlocal formatoptions+=tcql
        " When editing mail, set the textwidth to 72 and wrap lines.  Allow formatting
        " of comments with gq (but don't autowrap), and try to recognise numbered lists.
        autocmd FileType mail setlocal textwidth=72 formatoptions+=nq formatoptions-=c
        if has("spell")
            autocmd FileType mail setlocal spell
        endif
        " Add <> to the list of characters Vim will honour the showmatch setting for,
        " when editing HTML.
        autocmd FileType html setlocal matchpairs+=<:>
        " Load omnicompletion 
        if exists("+omnifunc")
            autocmd FileType * exe "runtime autoload/" . expand("<amatch>") . "complete.vim"
            autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType c          setlocal omnifunc=ccomplete#Complete
            autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
            autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
            autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
            " TODO: syntax completion using generic syntax completion thing.
        endif

        if has("eval")
            " More autocommands: call functions to do magic things when editing various
            " new files.
            autocmd BufNewFile *.h call CS_populate_header()
            autocmd BufNewFile *.c call CS_populate_c()
            autocmd BufNewFile *.java call CS_populate_java()
            autocmd BufNewFile *.pl,*.pm,*.cgi call CS_populate_perl()
            "autocmd BufNewFile *.py call CS_populate_python()
            autocmd FileType perl call CS_populate_perl()
            "autocmd FileType python call CS_populate_python()
        endif
    endif

    " Syntax on! {{{1
    " Various settings above will have affected the syntax highlighting, so turn
    " it back on now.
    syntax on
    " Enable FileType specific plugins and indentation.
    filetype plugin indent on
endif

" Now make changes to syntax highlighting. {{{1

" Change the colour of comments; DarkBlue is too dark on a dark background.
" This may not be necessary with Vim 6.3, where the default seems to be
" DarkGreen on dark backgrounds.  Which is nicer, DarkCyan or DarkGreen?
if has("syntax")
    highlight Comment ctermfg=DarkGreen
endif


if has("eval")
    " Functions to do magic things when you start editing a new file.
    " Populate a C header file.
    function! CS_populate_header() " {{{1
        " Don't execute this function a second time.
        if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
            return
        endif
        " Figure out the uppercased filename.
        let b:CS_define = toupper ( expand ( "%:t" ) )
        " Replace out all non-word characters with _, to keep cpp happy.
        let b:CS_define = substitute ( b:CS_define, "\\W", "_", "g" )
        insert
/* $CVSId$ */
#ifndef GUARD
#define GUARD



#endif /* GUARD */
.
        " Substitute CVSId with Id, so that cvs doesn't mangle THIS file.
        silent %s/CVSId/Id/
        " Substitute GUARD with our individualised guard.
        exe "silent %s/GUARD/" . b:CS_define . "/"
        " Delete the empty trailing line.
        $delete
        " Go to line 5.
        call cursor ( 5, 0 )
    endfunction

    " Populate a c source file.
    function! CS_populate_c() " {{{1
        " Don't execute this function a second time.
        if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
            return
        endif
        " Can't use normal with insert, wonder why.
        insert
/* $CVSId$ */
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>


.
        " Substitute CVSId with Id, so that cvs doesn't mangle THIS file.
        silent %s/CVSId/Id/
        call cursor( 7, 0 )
        " Figure out the filename to include, and include it if it exists.
        let b:CS_header = expand ( "%:t:r" ) . ".h"
        if filereadable( b:CS_header )
            call append ( 5, "#include \"" . b:CS_header . "\"" )
            call append ( 6, "" )
            call append ( 7, "\/* XXX " . b:CS_header . " included below for prototypes XXX */" )
            " How this works:
            " Use normal to make sure we don't use a mapping: this doesn't
            " work though???
            " Execute the contents of the string - like Perl's eval. 
            " The string breaks down to:
            " Read the output of the command into the current file.
            " Use sed to delete all #include lines in the header file,
            " then pipe the output into cpp.
            " cpp preprocesses it, leaves the comments in (-C) and doesn't
            " produce #line directives (-P);  basically we get the
            " function prototypes out of the header file, making it easier
            " to add the function body.
            execute "silent read! sed -e '/^\\#include/d' " . b:CS_header
                \ . " | cpp -P -C -"
            call cursor ( 11, 0 )
        endif
    endfunction

    " Populate Perl source.
    function! CS_populate_perl() " {{{1
        " Don't execute this function a second time.
        if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
            return
        endif
        insert
#!/usr/bin/env perl

use strict;
use warnings;


.
        call cursor ( line ( "$" ), 0 )
        set filetype=perl
    endfunction

    " Populate sh source.
    function! CS_populate_python() " {{{1
        " Don't execute this function a second time.
        if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
            return
        endif
        insert
#!/usr/bin/env python


.
        call cursor ( line ( "$" ), 0 )
        set filetype=python
    endfunction

    " Populate sh source.
    function! CS_populate_sh() " {{{1
        " Don't execute this function a second time.
        if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
            return
        endif
        insert
#!/bin/sh

set -e

.
        call cursor ( line ( "$" ), 0 )
        set filetype=sh
    endfunction

    " Populate Java source.
    function! CS_populate_java() " {{{1
        " Don't execute this function a second time.
        if ( line ( "$" ) != 1 || getline ( "$" ) != "" )
            return
        endif
        " Figure out the class name.
        let b:CS_class_name = expand ( "%:t:r" )
        insert
class CLASSNAME {
    public CLASSNAME () {
            
    }
}
.
        exe "silent %s/CLASSNAME/" . b:CS_class_name . "/"
        " Delete the trailing line.
        $delete
        " Go to line 3, ready to edit.
        call cursor ( 3, 2 )
    endfunction
endif


" Mapping keys to commands: {{{1
" Make F2 be justify, in various modes.  This is a global mapping, and will
" affect every open buffer.
 noremap <F2> gqap
" Use gwap in insert mode, it should leave the cursor where it started.
inoremap <F2> <C-O>gwap
vnoremap <F2> gq