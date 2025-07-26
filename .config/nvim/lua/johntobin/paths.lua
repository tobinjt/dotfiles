local M = {
  gemini_api_key = "~/.config/gemini/api_key",
}

-- Expands a given path and checks whether it exists.
-- @param path (string) path to expand and check for existence.
-- @return (boolean) Returns true if path exists, false otherwise.
function M.exists(path)
  local expanded = vim.fn.expand(path)
  return (vim.fn.filereadable(expanded) == 1) or (vim.fn.isdirectory(expanded) == 1)
end

--- Checks if file1 is newer than file2.
-- @param file1 (string) Path to the first file.
-- @param file2 (string) Path to the second file.
-- @return (boolean) Returns true if file1 is newer or file2 doesn't exist.
--                   Returns false if file2 is newer or file1 doesn't exist.
function M.is_file_newer(file1, file2)
  local mtime1 = vim.fn.getftime(file1)
  local mtime2 = vim.fn.getftime(file2)
  return mtime1 > mtime2
end

return M
