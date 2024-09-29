-- Note: some plugin configs also contain LSP config, e.g. lua.lua.
return {
  {
    "neovim/nvim-lspconfig",
    -- Dependencies are not necessary in other configs, setting them once is
    -- enough.
    dependencies = {
      "cmp-nvim-lsp",
      "mason-lspconfig.nvim",
    },

    -- The servers to enable are collected in opts.enabled_servers with the
    -- server options if any.
    -- require("lspconfig").start() doesn't exist so don't call it.
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, server_opts in pairs(opts.enabled_servers) do
        lspconfig[server].setup(server_opts)
      end
    end,

    opts = {
      enabled_servers = {
        -- keep-sorted start
        bashls = {},
        gopls = {},
        pylsp = {},
        ruff = {},
        rust_analyzer = {},
        vimls = {},
        -- keep-sorted end
      },
    }
  },
}
