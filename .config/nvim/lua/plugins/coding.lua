-- Check out https://docs.astronvim.com/reference/default_plugins/
return {
  {
    -- VCS indicators in the signs column.
    dir = vim.fn.expand("~/.vim/bundle/vim-signify"),
    lazy = false,
  },

  -- Windows for LSP diagnostics and other things.
  -- "folke/trouble.nvim",
  -- Generic formatting support.  Needs configuration for each formatter.
  -- "stevearc/conform.nvim",
  -- Asynchronous linting that reports through neovim's standard reporting.
  -- Similar to ALE but doesn't include an LSP client.
  -- "mfussenegger/nvim-lint",
  -- Use Treesitter to define custom text objects.
  -- "nvim-treesitter/nvim-treesitter-textobjects",
}
