local functions = require('johntobin.functions')

vim.api.nvim_create_user_command('ToggleInlayHints', functions.ToggleInlayHints,
  { desc = "Toggle LSP inlay hints for the current buffer" })
