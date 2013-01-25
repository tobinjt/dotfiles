" TmuxSetWindowName: When running under tmux(1), set the window's title to the
"                    name of the file being edited.
" Author:            John Tobin <johntobin@johntobin.ie>
" Date:              2011/06/13
" Version:           1

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
let g:loaded_TmuxSetWindowName = 'v1'

function! TmuxGetWindowList()
  " Return a list of tmux wndows in the current session.
  " There's a bug in libevent/Linux: epoll doesn't work on filesystem file
  " descriptors, but it does work on socket and pipe file descriptors.
  " Redirecting the output of tmux to a file causes it to hang, but piping the
  " output works, so I pipe tmux's output to cat and vim redirects the output of
  " the whole command.
  return split(system('tmux list-windows 2>&1 | cat'), '\n')
endfunction

function! TmuxWindowListToDict(window_list)
  " Convert the output of TmuxGetWindowList() to a dict mapping window numbers
  " to window titles.
  " We start with lines like:
  "   0: bash [176x45] [layout  bdf,176x45,0,0] (active)
  "   2: bash [176x45] [layout  bdf,176x45,0,0]
  "   0: bash  (1 panes) [191x39] [layout cf3d,191x39,0,0,0] @0
  "   1: vim TmuxSetWindowName.vim- (1 panes) [191x39] [layout cf3e,191x39,0,0,1] @1
  "   2: * (1 panes) [191x39] [layout cf40,191x39,0,0,3] @3 (active)
  " We strip those back to:
  "   0: bash
  "   2: bash
  " Then return:
  "   dict = {
  "     '0': 'bash',
  "     '2': 'bash',
  "   }

  let dict = {}
  for orig_line in a:window_list
    let line = orig_line
    let line = substitute(line, ' (active)$', '', '')
    let line = substitute(line, ' @\d\+$', '', '')
    " [layout cf3e,191x39,0,0,1]
    " [layout 2b5f,205x57,0,0]
    let line = substitute(line,
      \' \[layout\s\+\w\+,\d\+x\d\+,\d\+,\d\+\(,\d\+\)\?\]$', '', '')
    let line = substitute(line, ' \[\d\+x\d\+\]$', '', '')
    let line = substitute(line, ' (\d\+ panes)$', '', '')
    let line = substitute(line, '[-*]$', '', '')
    let matches = matchlist(line, '^\(\d\+\): \(.*\)$')
    if empty(matches)
      echomsg 'TmuxWindowListToDict: Unparsed line: "'
       \        . orig_line
       \        . '" shortened to: "'
       \        . line
       \        . '"'
    else
      let dict[matches[1]] = matches[2]
    endif
  endfor
  return dict
endfunction

function! TmuxGetWindowName()
  " Get the name of the current window.
  let orig_window_names = TmuxWindowListToDict(TmuxGetWindowList())
  let temp_name = tempname()
  call TmuxSetWindowName(temp_name)
  let new_window_names = TmuxWindowListToDict(TmuxGetWindowList())

  let window_id = -1
  let orig_window_names[window_id] = 'Unable to find window name'
  for [id, name] in items(new_window_names)
    if name == temp_name
      let window_id = id
      break
    endif
  endfor

  call TmuxSetWindowName(orig_window_names[window_id])
  return orig_window_names[window_id]
endfunction

function! TmuxSetWindowName(name)
  " Set the name of the current window.
  " Pipe into true to avoid epoll hangs, as described in TmuxGetWindowList.
  call system('tmux rename-window -t '
   \            . shellescape($TMUX_PANE)
   \            . ' '
   \            . shellescape(a:name)
   \            . ' 2>&1 | true')
endfunction

" XXX ALLOW DISABLING ADDITIONAL_INFO?
" XXX readonly and modified statuses don't update when you set noreadonly or
"     change a file.  I don't know if I should keep them.
function! TmuxFormatFilenameForDisplay()
  " Format the filename for display, adding extra information.
  let display_name = expand('%:t')
  if display_name == ''
    let display_name = '[No Name]'
  endif

  let additional_info_list =
    \ [&readonly           ? 'RO'   : '',
    \  &filetype == 'help' ? 'Help' : '',
    \  &modified           ? '+'    : '',
    \ ]
  let additional_info =
    \ join(map(filter(additional_info_list,
    \                 'strlen(v:val) > 0'),
    \          '"[" . v:val . "]"'),
    \       '')

  return join(filter(['vim',
    \                 additional_info,
    \                 display_name,
    \                ],
    \                'strlen(v:val) > 0'),
    \         ' ')
endfunction

function! TmuxSetWindowNameToFilename()
  " Set the window name to the name of the current file, with some additional
  call TmuxSetWindowName(TmuxFormatFilenameForDisplay())
endfunction

" Restore the original window name when leaving.
let s:orig_window_name = TmuxGetWindowName()
autocmd VimLeavePre * call TmuxSetWindowName(s:orig_window_name)
" Set the tmux window name when moving between vim buffers (moving between
" windows implies moving between buffers), writing a file, or editing a
" different file.
autocmd BufReadPost,BufEnter,BufWritePost * call TmuxSetWindowNameToFilename()
