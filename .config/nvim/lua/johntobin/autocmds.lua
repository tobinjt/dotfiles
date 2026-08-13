local functions = require('johntobin.functions')

-- Populate shell scripts.
vim.api.nvim_create_autocmd("BufNewFile", {
  group = "johntobin",
  pattern = "*.sh",
  callback = function()
    functions.PopulateSH()
    vim.opt.filetype = 'sh'
  end
})
vim.api.nvim_create_autocmd("FileType", {
  group = "johntobin",
  pattern = "sh",
  callback = function()
    if vim.fn.line('$') == 1 and vim.fn.getline(1) == '' then
      functions.PopulateSH()
    end
  end
})

-- Toggle formatoptions dynamically in Markdown code blocks
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = "johntobin",
  pattern = "*.md",
  callback = function()
    if functions.in_markdown_code_block() then
      vim.opt_local.formatoptions:remove('a')
    else
      vim.opt_local.formatoptions:append('a')
    end
  end,
})
