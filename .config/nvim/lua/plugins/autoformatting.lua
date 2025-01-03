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
      -- I can configure additional formatters here, but for now the LSP servers
      -- are covering all the file types I've tested.
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        markdown = {
          "mdformat",
          "prettier",
        },
      },
      formatters = {
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
