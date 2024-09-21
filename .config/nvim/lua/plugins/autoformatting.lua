return {
  {
    'stevearc/conform.nvim',
    opts = {
      -- I can configure additional formatters here, but for now the LSP servers
      -- are covering all the file types I've tested.
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  }
}
