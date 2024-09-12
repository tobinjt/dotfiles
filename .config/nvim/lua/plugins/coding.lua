-- Check out https://docs.astronvim.com/reference/default_plugins/
return {
  -- Change markers signs and Git support.  No Mercurial support.
  "lewis6991/gitsigns.nvim",

  -- LSP support.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
  },

  -- Automatic installation and configuration of LSP servers, linters, and more.
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

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
