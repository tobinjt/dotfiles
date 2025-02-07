-- Highlight the three columns after textwidth with a different color, but
-- only if there is text to highlight.
local autocmd_callback = function()
  -- Need a non-zero textwidth.
  if vim.o.textwidth == 0 then
    return
  end
  -- Some filetypes have really long lines and are too noisy.
  local filetypes_to_ignore = {
    -- keep-sorted start
    'go',
    'help',
    -- keep-sorted end
  }
  if vim.tbl_contains(filetypes_to_ignore, vim.o.filetype) then
    return
  end

  -- Clean up old matches.
  if vim.b.colorcolum_matchadd_id then
    vim.fn.matchdelete(vim.b.colorcolum_matchadd_id)
  end

  -- Create the new match.
  -- See: :help /\zs; matches after the specified column.
  -- TODO: experiment with :help /\%v to match on virtual columns rather than
  -- characters.  The current regex won't work well with tabs because each tab
  -- is a single character but occupies multiple screen columns.
  local regex = '^.\\{' .. vim.o.textwidth .. '}\\zs.\\{1,3}'
  vim.b.colorcolum_matchadd_id = vim.fn.matchadd('WarningMsg', regex)
end

vim.api.nvim_create_autocmd({ "OptionSet" }, {
  desc = "Highlight column after textwidth",
  -- Relies on the augroup being created in autocmd.vim.
  group = "johntobin",
  pattern = "textwidth",
  callback = autocmd_callback,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  desc = "Highlight column after textwidth",
  -- Relies on the augroup being created in autocmd.vim.
  group = "johntobin",
  callback = autocmd_callback,
})
