local M = {
  gemini_api_key = "~/.config/gemini/api_key",
}

-- Expands a given path and checks whether it exists.
function M.exists(path)
  local expanded = vim.fn.expand(path)
  return (vim.fn.filereadable(expanded) == 1) or (vim.fn.isdirectory(expanded) == 1)
end

return M
