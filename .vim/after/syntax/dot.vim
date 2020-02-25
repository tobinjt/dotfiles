" Set up spell checking for strings and comments only.
" Clear out the existing rules for strings and comments, because new rules will
" be appended rather than replacing.
syntax clear dotComment dotString
" These are the rules from syntax/dot.vim, but with contains=@Spell added.
syn region   dotComment start="//" end="$" contains=dotComment,dotTodo,@Spell
syn region   dotComment start="/\*" end="\*/" contains=dotComment,dotTodo,@Spell
syn region   dotString  start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
