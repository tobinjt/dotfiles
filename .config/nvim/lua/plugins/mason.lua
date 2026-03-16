-- Automatic installation and configuration of LSP servers, linters, and more.
-- Required setup order from :h mason-lspconfig-quickstart:
-- - mason
-- - mason-lspconfig
-- - configure LSP servers.
-- I have configured dependencies in lsp.lua to do this.

local tools = require("johntobin.tools")

return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- Prepending means I can't write wrappers, so append.
      -- Mason's bin dir is in my PATH already, so this should be a no-op, but
      -- just in case let's append.
      PATH = "append",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- Automatic enabling is problematic when there are multiple servers for
      -- one filetype, so disable it.
      automatic_enable = false,
    },
    dependencies = {
      "mason.nvim",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Don't install tooling for other users.
    cond = vim.fn.getenv("USER") == "johntobin",
    dependencies = {
      "mason.nvim",
      -- Configured in lsp.lua.
      "mason-lspconfig.nvim",
      -- Configured in debugging.lua.
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = {
      auto_update = true,
      -- Wait 24 hours between installation checks.
      -- Delete ~/.local/share/nvim/mason-tool-installer-debounce
      debounce_hours = 24,
      ensure_installed = tools.make_mason_package_install_list(),
    },
  },
}
