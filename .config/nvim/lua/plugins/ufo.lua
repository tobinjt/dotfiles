-- Make folding more predictable, in particular stop folds closing unexpectedly.

-- Fold options are required for ufo to work
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  lazy = false,

  keys = {
    {
      'zR',
      function() require('ufo').openAllFolds() end,
      desc = 'Open all folds',
    },
    {
      'zM',
      function() require('ufo').closeAllFolds() end,
      desc = 'Close all folds',
    },
    {
      'zP',
      function()
        local peeked = require('ufo').peekFoldedLinesUnderCursor()
        if not peeked then
          vim.lsp.buf.hover()
        end
      end,
      desc = 'Peek Fold',
    },
  },

  opts = {
    -- https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
    -- Use treesitter for Markdown, LSP for everything else.
    provider_selector = function(_, filetype, _)
      if filetype == 'markdown' then
        return { 'treesitter', 'indent', }
      end
      return { 'lsp', 'indent', }
    end
  }
}
