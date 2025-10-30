local paths = require("johntobin.paths")

return {
  {
    "mfussenegger/nvim-lint",
    cond = paths.installer_is_available_function("luacheck")(),
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
          root_markers = {
            -- This is copied from nvim-lspconfig/lsp/lua_ls.lua and extended
            -- with .exercism so that when working on Exercism exercises I only
            -- load the current exercise not the entire set.
            -- I would prefer to load the base list from nvim-lspconfig, but
            -- that means either I require that module which will break
            -- bootstrapping, or I make this opts a function and multiple opts
            -- functions can be tricky to manage.
            -- TODO: experiment with making this a function.
            --
            -- keep-sorted start
            ".exercism",
            ".luacheckrc",
            ".luarc.json",
            ".luarc.jsonc",
            ".stylua.toml",
            "selene.toml",
            "selene.yml",
            "stylua.toml",
            -- keep-sorted end
            -- Keep .git to the end because the others are more specific.
            ".git",
          },
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
