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

" The `:` is required to make it an ex command, and the `<CR>` is required to
" execute it.
nnoremap <leader>wc :call WrapCommentBlock()<CR>
