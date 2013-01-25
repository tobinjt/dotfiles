" vim: set filetype=vim :
if !has("user-commands")
  finish
endif
command! WordGrep call Grep('\<' . expand('<cword>') . '\>')
command! ReGrep call ReGrep()
command! -nargs=1 Grep call Grep(<q-args>)
command! W w
