" TmuxSetWindowName: When running under tmux(1), set the window's title to the
"                    name of the file being edited.
" Author:            John Tobin <johntobin@johntobin.ie>
" Date:              2016/10/30
" Version:           2

if ! has('eval')
  finish
endif
if ! exists('$TMUX')
  finish
endif
if ! exists('$TMUX_PANE')
  finish
endif
if exists('g:loaded_TmuxSetWindowName')
  finish
endif
let g:loaded_TmuxSetWindowName = 'v2'
let g:TmuxSetWindowName_EnableTimers = 0
let s:last_update_timestamp = 0
if ! exists('g:TmuxSetWindowName_RefreshIntervalMilliseconds')
  let g:TmuxSetWindowName_RefreshIntervalMilliseconds = 5000  " 5 seconds.
endif
if ! exists('g:TmuxGetWindowName_Enabled')
  let g:TmuxGetWindowName_Enabled = 1
endif

function! TmuxGetWindowList()
  " Return a list of tmux wndows in the current session.
  let l:cmd = 'tmux list-windows -F "#{pane_id} #{window_name}" 2>&1'
  return systemlist(l:cmd)
endfunction

function! TmuxWindowListToDict(window_list)
  " Convert the output of TmuxGetWindowList() to a dict mapping window numbers
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
      echomsg 'TmuxWindowListToDict: Unparsed line: "' . line . '"'
    else
      let l:dict[l:matches[1]] = l:matches[2]
    endif
  endfor
  return l:dict
endfunction

function! TmuxGetWindowName()
  " Get the name of the current window.
  let l:window_names = TmuxWindowListToDict(TmuxGetWindowList())
  for [l:id, l:name] in items(l:window_names)
    if l:id == $TMUX_PANE
      return l:name
    endif
  endfor

  return 'Unable to find window name'
endfunction

function! TmuxSetWindowName(name, redraw, ignore_timeout)
  " Set the name of the current window if necessary.
  " Args:
  "   name: the new name of the window
  "   redraw: if redraw == 1, :redraw to refresh the screen.
  "   ignore_timeout: if ignore_timeout == 1, update even if the timeout hasn't
  "   expired.
  if a:ignore_timeout == 0
    let s:current_timestamp = localtime()
    " Convert milliseconds to seconds.
    let s:timeout = g:TmuxSetWindowName_RefreshIntervalMilliseconds / 1000
    if s:last_update_timestamp + s:timeout > s:current_timestamp
      return
    endif
    let s:last_update_timestamp = s:current_timestamp
  endif

  let s:current_window_name = TmuxGetWindowName()
  if s:current_window_name == a:name
    return
  endif

  call system('tmux rename-window -t '
   \            . shellescape($TMUX_PANE)
   \            . ' '
   \            . shellescape(a:name)
   \            . ' 2>&1')
  if a:redraw == 1
    redraw
  endif
endfunction

function! TmuxFormatFilenameForDisplay()
  " Format the filename for display, adding extra information.
  let l:display_name = expand('%:t')
  if l:display_name ==# ''
    let l:display_name = '[No Name]'
  endif

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

  return join(filter(['vim',
    \                 l:additional_info,
    \                 l:display_name,
    \                ],
    \                'strlen(v:val) > 0'),
    \         ' ')
endfunction

function! TmuxSetWindowNameToFilename(ignore_timeout)
  " Set the window name to the name of the current file plus additional info.
  if g:TmuxGetWindowName_Enabled == 1
    call TmuxSetWindowName(TmuxFormatFilenameForDisplay(), 0, a:ignore_timeout)
  endif
endfunction

function! TmuxSetWindowNameCalledByTimer(timer)
  " Set the window name to the name of the current file plus additional info.
  if g:TmuxGetWindowName_Enabled == 1
    call TmuxSetWindowName(TmuxFormatFilenameForDisplay(), 1, 0)
  endif
endfunction

function! NoTmuxSetWindowName()
  let g:TmuxGetWindowName_Enabled = 0
endfunction

function! YesTmuxSetWindowName()
  let g:TmuxGetWindowName_Enabled = 1
endfunction

" Restore the original window name when leaving.
let s:orig_window_name = TmuxGetWindowName()
augroup TmuxSetWindowName
  autocmd!
  autocmd VimLeavePre * call TmuxSetWindowName(s:orig_window_name, 0, 1)
  " Set the tmux window name when moving between vim buffers (moving between
  " windows implies moving between buffers), writing a file, or editing a
  " different file.
  autocmd BufReadPost,BufEnter,BufWritePost * call TmuxSetWindowNameToFilename(1)
  " Set the tmux window name when entering or leaving insert mode so it's set
  " after suspending.
  autocmd InsertEnter,InsertLeave * call TmuxSetWindowNameToFilename(0)
augroup END

" Set the window name periodically so it is set correctly after suspending.
if has('timers') && g:TmuxSetWindowName_EnableTimers == 1
  call timer_start(g:TmuxSetWindowName_RefreshIntervalMilliseconds,
                 \ 'TmuxSetWindowNameCalledByTimer',
                 \ {'repeat': -1})
endif
