local M = {}

-- Return the syntax ID under the cursor.
M.SyntaxIDUnderCursor = function()
  return vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
end

-- Return the name of the syntax highlighting group under the cursor.
M.SyntaxUnderCursor = function()
  return vim.fn.synIDattr(M.SyntaxIDUnderCursor(), 'name')
end

-- Turn off line numbers and sign column.
M.TurnOffLineNumbersAndSigns = function()
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.signcolumn = 'no'
end

-- Turn on line numbers and sign column.
M.TurnOnLineNumbersAndSigns = function()
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = 'auto'
end

-- Functions to do magic things when you start editing a new file.
M.PopulateSH = function()
  -- Don't execute this function a second time.
  if vim.fn.line('$') ~= 1 or vim.fn.getline('$') ~= '' then
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    '#!/bin/bash',
    '',
    'set -e -f -u -o pipefail',
    '',
    '.'
  })
  vim.fn.cursor(vim.fn.line('$'), 0)
  vim.opt.filetype = 'sh'
end

-- Start profiling.
M.StartProfiling = function()
  vim.cmd('profile start profile.log')
  vim.cmd('profile file *')
  vim.cmd('profile func *')
end

-- Stop profiling.
M.StopProfiling = function()
  vim.cmd('profile stop')
end

return M
