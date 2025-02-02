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
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_format = "fallback",
      },

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
  }
}
