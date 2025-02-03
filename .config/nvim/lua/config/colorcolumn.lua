-- Highlight the three columns after textwidth with a different color, but
-- only if there is text to highlight.
-- TODO: need to disable this for certain filetypes, e.g. help and golang.
-- TODO: does this fire after filetype is set or before?
-- TODO: does this use global textwidth or buffer-local textwidth?
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  desc = "Highlight column after textwidth",
  -- Relies on the augroup being created in autocmd.vim.
  group = "johntobin",
  callback = function()
    -- See: :help /\zs; matches after the specified column.
    vim.fn.matchadd('WarningMsg', '^.\\{' .. vim.o.textwidth .. '}\\zs.\\{1,3}')
  end,
})
