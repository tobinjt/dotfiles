set history filename ~/.gdb_history
set history save on
set history size 102400
set confirm off
# set breakpoint pending on
define gobreakpoints
  break main.breakpoint
end
define gosupport
  source ~/src/go-gdb-support.py
end
define gomacosx
  gosupport
  gobreakpoints
end
