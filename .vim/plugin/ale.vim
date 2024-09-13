" ALE
" Autofix if available.
let g:ale_fix_on_save = 1
" Automatically fix Typescript.
let g:ale_fixers = {
  \  'typescript': [
  \    'eslint',
  \  ],
  \}
" Recognise the global variables Neovim provides.
let g:ale_lua_luacheck_options = '--globals vim'
