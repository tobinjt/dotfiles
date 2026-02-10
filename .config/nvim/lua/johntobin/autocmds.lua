local functions = require('johntobin.functions')

-- Populate shell scripts.
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  callback = function()
    functions.PopulateSH()
    vim.opt.filetype = 'sh'
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
      functions.PopulateSH()
    end
  end
})
