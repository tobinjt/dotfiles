-- Check out https://docs.astronvim.com/reference/default_plugins/
return {
  -- Easily comment or uncomment lines.
  "numToStr/Comment.nvim",

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

  -- Syntax highlighting and more.
  {
    "nvim-treesitter/nvim-treesitter",
    -- Based on https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
    -- treesitter.setup() doesn't install parsers, instead we need
    -- treesitter.config.setup(opts).
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
      ensure_installed = {
        "bash",
        "go",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "vim",
        "vimdoc",
      },
    },
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
