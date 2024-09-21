return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")
      lint.linters.luacheck.args = {
        "--globals",
        "vim",
        table.unpack(lint.linters.luacheck.args),
      }
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft["lua"] = { "luacheck" }
      return opts
    end
  },

  {
    "neovim/nvim-lspconfig",
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
