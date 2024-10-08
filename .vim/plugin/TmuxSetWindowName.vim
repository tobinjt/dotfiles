" TmuxSetWindowName: When running under tmux(1), set the window's title to the
"                    name of the file being edited.
" Author:            John Tobin <johntobin@johntobin.ie>
" Date:              2016/10/30
" Version:           2

if ! exists('$TMUX')
  finish
endif
if exists('g:loaded_TmuxSetWindowName')
  finish
endif
let g:loaded_TmuxSetWindowName = 'v2'
let s:last_update_timestamp = 0

function! s:TmuxGetWindowList()
  " Return a list of tmux wndows in the current session.
  let l:cmd = 'tmux list-windows -F "#{pane_id} #{window_name}" 2>&1'
  return systemlist(l:cmd)
endfunction

function! s:TmuxWindowListToDict(window_list)
  " Convert the output of s:TmuxGetWindowList() to a dict mapping window numbers
  " to window titles.
  " We start with lines like:
  "   %0 vim foo.txt
  "   %1
  " Then return:
  "   dict = {
  "     '%0': 'vim foo.txt',
  "     '%1': '',
  "   }

  let l:dict = {}
  for l:line in a:window_list
    let l:matches = matchlist(l:line, '^\(%\d\+\) \(.*\)$')
    if empty(l:matches)
      echomsg 'TmuxWindowListToDict: Unparsed line: "' . l:line . '"'
    else
      let l:dict[l:matches[1]] = l:matches[2]
    endif
  endfor
  return l:dict
endfunction

function! s:TmuxGetWindowName()
  " Get the name of the current window.
  let l:window_names = s:TmuxWindowListToDict(s:TmuxGetWindowList())
  for [l:id, l:name] in items(l:window_names)
    if l:id == $TMUX_PANE
      return l:name
    endif
  endfor

  return 'Unable to find window name'
endfunction

function! s:TmuxSetWindowName(name, ignore_timeout)
  " Set the name of the current window if necessary.
  " Args:
  "   name: the new name of the window
  "   ignore_timeout: if ignore_timeout is true, update even if the timeout
  "                   hasn't expired.
  let l:current_timestamp = localtime()
  if a:ignore_timeout is v:false
        \ && s:last_update_timestamp + 5 > l:current_timestamp
    return
  endif
  let s:last_update_timestamp = l:current_timestamp

  let l:current_window_name = s:TmuxGetWindowName()
  if l:current_window_name == a:name
    return
  endif

  call system('tmux rename-window -t '
   \            . shellescape($TMUX_PANE)
   \            . ' '
   \            . shellescape(a:name)
   \            . ' 2>&1')
endfunction

function! s:TmuxFormatFilenameForDisplay(display_name)
  " Format the filename for display, adding extra information.
  let l:additional_info_list =
    \ [&readonly            ? 'RO'   : '',
    \  &filetype ==# 'help' ? 'Help' : '',
    \  &modified            ? '+'    : '',
    \ ]
  let l:additional_info =
    \ join(map(filter(l:additional_info_list,
    \                 'strlen(v:val) > 0'),
    \          '"[" . v:val . "]"'),
    \       '')

  if has('nvim')
    let l:editor = 'nvim'
  else
    let l:editor = 'vim'
  endif
  return join(filter([l:editor,
    \                 l:additional_info,
    \                 a:display_name,
    \                ],
    \                'strlen(v:val) > 0'),
    \         ' ')
endfunction

function! s:TmuxSetWindowNameToFilename(ignore_timeout)
  " Set the window name to the name of the current file plus additional info.
  let l:display_name = expand('%:t')
  if l:display_name ==# ''
    return
  endif

  call s:TmuxSetWindowName(
      \ s:TmuxFormatFilenameForDisplay(l:display_name), a:ignore_timeout)
endfunction

" Restore the original window name when leaving.
let s:orig_window_name = s:TmuxGetWindowName()
augroup TmuxSetWindowName
  autocmd!
  autocmd VimLeavePre * call s:TmuxSetWindowName(s:orig_window_name, v:true)
  " Set the tmux window name when moving between vim buffers (moving between
  " windows implies moving between buffers), writing a file, or editing a
  " different file.
  autocmd BufReadPost,BufEnter,BufWritePost *
      \ call s:TmuxSetWindowNameToFilename(v:true)
  " Set the tmux window name when entering or leaving insert mode so it's set
  " after suspending.
  autocmd InsertEnter,InsertLeave * call s:TmuxSetWindowNameToFilename(v:false)
augroup END
