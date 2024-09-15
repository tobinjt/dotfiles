return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    -- See comments in lsp.lua about how the split setup works.
    opts = function(_, opts)
      require("lspconfig").lua_ls.setup {
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
              -- This is copied from a post on Reddit, I don't know how
              -- necessary it is.
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      }
      return opts
    end
  },
}
