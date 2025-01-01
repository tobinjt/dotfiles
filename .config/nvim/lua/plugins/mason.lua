-- Automatic installation and configuration of LSP servers, linters, and more.
-- Required setup order from :h mason-lspconfig-quickstart:
-- - mason
-- - mason-lspconfig
-- - configure LSP servers.
-- I have configured dependencies in lsp.lua to do this.
return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      "mason.nvim",
    },
  },
}
