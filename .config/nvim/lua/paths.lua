local M = {}

-- Expands a given path and checks whether it exists.
function M.exists(path)
  local expanded = vim.fn.expand(path)
  return vim.fn.filereadable(expanded) == 1
end

return M
