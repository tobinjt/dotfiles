local M = {
  gemini_api_key_path = "~/.config/gemini/api_key",
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

--- If the file containing the Gemini API key exists: read the file, set the
--- environment variable GEMINI_API_KEY, and store the api key in
--- M.gemini_api_key.
function M.load_gemini_api_key()
  if not M.exists(M.gemini_api_key_path) then
    return
  end
  local expanded_path = vim.fn.expand(M.gemini_api_key_path)
  M.gemini_api_key = vim.fn.readfile(expanded_path)[1]
  vim.fn.setenv("GEMINI_API_KEY", M.gemini_api_key)
end

-- This function returns a function to check whether installer is available.
-- It will be used in the config for mason-tool-installer.
function M.installer_is_available_function(installer)
  return function()
    return vim.fn.executable(installer) == 1
  end
end

return M
