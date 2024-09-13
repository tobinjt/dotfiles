return {
  {
    -- Tab completion.
    dir = vim.fn.expand("~/.vim/bundle/supertab"),
    lazy = false,
  },
  {
    -- Improved status bar.
    dir = vim.fn.expand("~/.vim/bundle/vim-airline"),
    lazy = false,
  },
  {
    -- Makes filename:line-number[:column] work.
    dir = vim.fn.expand("~/.vim/bundle/vim-fetch"),
    lazy = false,
  },
}
