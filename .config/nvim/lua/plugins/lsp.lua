return {
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   "mason.nvim",
    --   "mason-lspconfig.nvim",
    -- },
    ft = {
      -- keep-sorted start
      "go",
      "lua",
      "python",
      "rust",
      "shell",
      -- keep-sorted end
    },
    config = function(_, _)
      local lspconfig = require("lspconfig")
      -- keep-sorted start
      lspconfig.bashls.setup{}
      lspconfig.gopls.setup{}
      lspconfig.pylsp.setup{}
      lspconfig.rust_analyzer.setup{}
      -- keep-sorted end

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global.
              globals = {
                'require',
                'vim'
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files.
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      }
    end
  },

  -- Automatic installation and configuration of LSP servers, linters, and more.
  -- "williamboman/mason.nvim",
  -- "williamboman/mason-lspconfig.nvim",
}
