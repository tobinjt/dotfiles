" Stop recognising _italics_ and *italics* because they show up in URLs and
" commands; htmlItalic still works but doesn't interfere as much.
syntax clear mkdItalic
" Stop recognising indented code blocks because I only use fenced code blocks.
" Second and subsequent paragraphs in lists are mis-recognised as mkdCode.
" Can't delete an individual match, so comment out this line in markdown.vim:
" syn match  mkdCode         /^\s*\n\(\(\s\{8,}[^ ]\|\t\t\+[^\t]\).*\n\)\+/
