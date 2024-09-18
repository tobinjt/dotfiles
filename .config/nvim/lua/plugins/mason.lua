-- Automatic installation and configuration of LSP servers, linters, and more.
-- Required setup order from :h mason-lspconfig-quickstart:
-- - mason
-- - mason-lspconfig
-- - configure LSP servers.
-- I have configured dependencies in lsp.lua to do this.
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        -- I want to control when package updates are made, at least at first.
        check_outdated_packages_on_open = false,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- Trigger setup so the plugin is functional.
    config = true,
    dependencies = {
      "mason.nvim",
      "nvim-lspconfig",
    },
  },
}
