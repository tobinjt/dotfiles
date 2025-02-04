-- To see the config for a single formatter:
-- :ConformInfo
-- :lua vim.print(require("conform").get_formatter_info("mdformat"))
-- :lua vim.print(require("conform").formatters.mdformat)
return {
  {
    'stevearc/conform.nvim',
    -- Requires Neovim 0.10 or later.
    cond = vim.fn.has("nvim-0.10") == 1,
    opts = {
      -- Support for enable/disable autoformat-on-save.
      -- Modified from
      -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable.
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          -- These options will be passed to conform.format().
          -- Long timeout because large Python files can be slow to format.
          timeout_ms = 5000,
          lsp_format = "fallback",
        }
      end,

      -- Run keep-sorted for every file type.
      -- This runs async after write, but it runs so fast that being async
      -- shouldn't be a problem.
      format_after_save = {
        -- These options will be passed to conform.format()
        formatters = {
          "keep_sorted",
        },
      },

      formatters_by_ft = {
        markdown = {
          "mdformat",
          "prettier",
        },
      },

      formatters = {
        keep_sorted = {
          command = "keep-sorted",
          -- This is ignored in many cases :(
          stdin = false,
          -- Force adding a filename so that keep-sorted works.
          args = {
            "$FILENAME",
          },
        },
        mdformat = {
          prepend_args = {
            "--wrap",
            "80",
          },
        },
      },
    },

    config = function(_, opts)
      require("conform").setup(opts)

      -- Add commands to enable/disable autoformat-on-save.
      -- Modified from
      -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
      vim.g.disable_autoformat = false
      vim.b.disable_autoformat = false
      vim.api.nvim_create_user_command("FormatDisable",
        function(args)
          if args.bang then
            -- FormatDisable! will disable formatting globally
            vim.g.disable_autoformat = true
          else
            vim.b.disable_autoformat = true
          end
        end,
        {
          desc = "Disable autoformat-on-save",
          bang = true,
        })
      vim.api.nvim_create_user_command("FormatEnable",
        function()
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
        end,
        {
          desc = "Re-enable autoformat-on-save",
        })
    end,
  }
}
