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
if ! exists('g:TmuxSetWindowName_RefreshIntervalMilliseconds')
  let g:TmuxSetWindowName_RefreshIntervalMilliseconds = 5000  " 5 seconds.
endif

function! TmuxGetWindowList()
  " Return a list of tmux wndows in the current session.
  let l:cmd = 'tmux list-windows -F "#{pane_id} #{window_name}" 2>&1'
  return split(system(l:cmd), '\n')
endfunction

function! TmuxWindowListToDict(window_list)
  " Convert the output of TmuxGetWindowList() to a dict mapping window numbers
  " to window titles.
  " We start with lines like:
  "   %0 vim TmuxSetWindowName.vim
  "   %1
  " Then return:
  "   dict = {
  "     '%0': 'vim TmuxSetWindowName.vim',
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

function! TmuxSetWindowName(name)
  " Set the name of the current window.
  let s:current_window_name = TmuxGetWindowName()
  if s:current_window_name == a:name
    return
  endif
  call system('tmux rename-window -t '
   \            . shellescape($TMUX_PANE)
   \            . ' '
   \            . shellescape(a:name)
   \            . ' 2>&1')
  redraw!
endfunction

function! TmuxFormatFilenameForDisplay()
  " Format the filename for display, adding extra information.
  let l:display_name = expand('%:t')
  if l:display_name == ''
    let l:display_name = '[No Name]'
  endif

  let l:additional_info_list =
    \ [&readonly           ? 'RO'   : '',
    \  &filetype == 'help' ? 'Help' : '',
    \  &modified           ? '+'    : '',
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

function! TmuxSetWindowNameToFilename()
  " Set the window name to the name of the current file plus additional info.
  call TmuxSetWindowName(TmuxFormatFilenameForDisplay())
endfunction

function! TmuxSetWindowNameCalledByTimer(timer)
  " Set the window name to the name of the current file plus additional info.
  call TmuxSetWindowName(TmuxFormatFilenameForDisplay())
endfunction

" Restore the original window name when leaving.
let s:orig_window_name = TmuxGetWindowName()
autocmd VimLeavePre * call TmuxSetWindowName(s:orig_window_name)
" Set the tmux window name when moving between vim buffers (moving between
" windows implies moving between buffers), writing a file, or editing a
" different file.
autocmd BufReadPost,BufEnter,BufWritePost * call TmuxSetWindowNameToFilename()
" Set the window name periodically so it is set correctly after suspending.
if has('timers')
  call timer_start(g:TmuxSetWindowName_RefreshIntervalMilliseconds,
                 \ 'TmuxSetWindowNameCalledByTimer',
                 \ {'repeat': -1})
endif
