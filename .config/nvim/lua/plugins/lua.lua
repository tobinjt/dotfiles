return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    -- Requires Neovim 0.10 or later.
    cond = vim.fn.has("nvim-0.10"),
    opts = {
      -- Force adding all the plugins I have so that type annotations work.
      library = vim.fn.split(vim.fn.glob('~/.local/share/nvim/lazy/*/lua'), "\n"),
    },
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
                'vim'
              },
            },
          },
        },
      }
      return opts
    end
  },
}
