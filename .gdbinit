set history filename ~/.gdb_history
set history save on
set history size 102400
set confirm off
# Needed for Mac OS Sierra; dunno if it works on other OSes.
set startup-with-shell off
# set breakpoint pending on
define gobreakpoints
  break main.breakpoint
end
define gosupport
  # This must link to runtime-gdb.py from Go.
  source ~/src/go-gdb-support.py
end
define gomacosx
  gosupport
  gobreakpoints
end
