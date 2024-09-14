return {
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   "mason.nvim",
    --   "mason-lspconfig.nvim",
    -- },
    lazy = false,
    ft = {
      -- keep-sorted start
      "go",
      "lua",
      "python",
      "rust",
      "shell",
      -- keep-sorted end
    },
    config = function(_, _opts)
      local lspconfig = require("lspconfig")
      -- keep-sorted start
      lspconfig.bashls.setup{}
      lspconfig.gopls.setup{}
      lspconfig.lua_ls.setup{}
      lspconfig.pylsp.setup{}
      lspconfig.rust_analyzer.setup{}
      -- keep-sorted end
    end
  },

  -- Automatic installation and configuration of LSP servers, linters, and more.
  -- "williamboman/mason.nvim",
  -- "williamboman/mason-lspconfig.nvim",
}
