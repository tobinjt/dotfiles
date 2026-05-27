local functions = require('johntobin.functions')
local tools = require('johntobin.tools')

vim.api.nvim_create_user_command('ToggleInlayHints', functions.ToggleInlayHints,
  { desc = "Toggle LSP inlay hints for the current buffer" })

vim.api.nvim_create_user_command('ToolsDebug', tools.debug,
  { desc = "Display results of tool configuration functions" })
