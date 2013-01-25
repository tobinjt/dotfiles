" Stop highlighting trailing spaces
syntax clear pythonSpaceError
" mixed tabs and spaces
syntax match   pythonSpaceError  display " \+\t"
syntax match   pythonSpaceError  display "\t\+ "
