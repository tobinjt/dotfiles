set encoding=utf-8
scriptencoding utf-8
" On some Apple keyboards shift-3 sends a weird pound sign, remap it to hash.
cnoremap £ #
inoremap £ #
lnoremap £ #
onoremap £ #
vnoremap £ #

cnoremap cwindow botright cwindow
cnoremap copen botright copen

" Remap ^W-F to open the file under the cursor in a vertical split.
nnoremap <C-W>F <C-W>vgF

" I always want help opened in a vertical split.
cnoremap help vertical help
