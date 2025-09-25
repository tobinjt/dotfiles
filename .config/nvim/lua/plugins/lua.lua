return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")
      lint.linters.luacheck.args = {
        "--globals",
        "vim",
        "--std",
        "+lua51",
        "--std",
        -- Might not be needed, based on `luacheck --help`?
        "+busted",
        table.unpack(lint.linters.luacheck.args),
      }
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft["lua"] = { "luacheck" }
      return opts
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Definitions for busted functions so LuaLS recognises them.  Doesn't add
      -- anything to Neovim.  Will be added to runtimepath, but shouldn't cause
      -- any issues.
      "LuaCATS/busted",
    },
    opts = {
      enabled_servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global.
                globals = {
                  "vim",
                },
              },
              workspace = {
                library = vim.fn.split(vim.fn.glob("~/.local/share/nvim/lazy/*/lua"), "\n"),
                userThirdParty = {
                  vim.fn.expand("~/.local/share/nvim/lazy/busted"),
                },
              },
            },
          },
        },
      },
    },
  },
}
