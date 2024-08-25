-- Check out https://docs.astronvim.com/reference/default_plugins/
return {
  -- Easily comment or uncomment lines.
  "numToStr/Comment.nvim",

  -- Automatic installation and configuration of LSP servers, linters, and more.
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  -- LSP support.
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
      -- "mason.nvim",
      -- { "williamboman/mason-lspconfig.nvim", config = function() end },
    -- },
  },

  -- Adds signs for changed lines.  Other stuff I'm not clear about.
  -- "lewis6991/gitsigns.nvim",
  -- Windows for LSP diagnostics and other things.
  -- "folke/trouble.nvim",
  -- Generic formatting support.  Needs configuration for each formatter.
  -- "stevearc/conform.nvim",
  -- Asynchronous linting that reports through neovim's standard reporting.
  -- Similar to ALE but doesn't include an LSP client.
  -- "mfussenegger/nvim-lint",
  -- Treesitter for syntax highlighting.  See
  -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
  -- for necessary config.
  -- "nvim-treesitter/nvim-treesitter"
  -- Use Treesitter to define custom text objects.
  -- "nvim-treesitter/nvim-treesitter-textobjects",
}
