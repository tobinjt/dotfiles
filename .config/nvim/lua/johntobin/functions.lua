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
  local lines = {
    "#!/bin/bash",
    "",
    "set -e -f -u -o pipefail",
    "",
    "main() {",
    "    ",
    "}",
    "",
    "main \"$@\"",
  }

  -- Set the lines in the current buffer (0)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Move the cursor to inside the main function.
  vim.api.nvim_win_set_cursor(0, { 6, 4 })
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

-- Update any spell files where the source is newer than the generated file.
M.UpdateSpellfilesIfNecessary = function()
  local paths = require("johntobin.paths")
  ---@diagnostic disable-next-line: undefined-field
  for _, spellfile in ipairs(vim.opt.spellfile:get()) do
    local splfile = spellfile .. ".spl"
    if paths.is_file_newer(spellfile, splfile) then
      local cmd = "mkspell! " .. spellfile
      vim.cmd(cmd)
    end
  end
end

-- Run a command, with args, if it exists. Warn if it doesn't exist.
M.RunCommandIfExists = function(command_name, ...)
  if vim.fn.exists(":" .. command_name) == 2 then
    local args = { ... }
    if #args > 0 then
      -- Join the command and all arguments with spaces
      local full_command = command_name .. " " .. table.concat(args, " ")
      vim.cmd(full_command)
    else
      -- Run command without args
      vim.cmd(command_name)
    end
  else
    io.stderr:write("Command '" .. command_name .. "' not found.\n")
  end
end

M.ToggleInlayHints = function()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Check if any attached LSP client supports inlay hints
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local supports_inlay = false
  for _, client in ipairs(clients) do
    if client:supports_method("textDocument/signatureHelp") then
      supports_inlay = true
      break
    end
  end
  if not supports_inlay then
    vim.notify("No LSP client attached to this buffer supports inlay hints.",
      vim.log.levels.WARN)
    return
  end

  -- Toggle inlay hints for the current buffer
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
  vim.notify("Inlay hints " .. (is_enabled and "disabled" or "enabled"),
    vim.log.levels.INFO)
end

return M
