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

    keys = {
      {
        "<leader>gd",
        vim.lsp.buf.definition,
        desc = "Goto Definition",
      },

      {
        "<leader>gt",
        vim.lsp.buf.type_definition,
        desc = "Goto Type Definition"
      },
    },

    -- The servers to enable are collected in opts.enabled_servers with the
    -- server options if any.  Config required by cmp-nvim-lsp is added
    -- automatically.
    -- require("lspconfig").start() doesn't exist so don't call it.
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = {
        capabilities = vim.tbl_deep_extend("force",
          vim.lsp.protocol.make_client_capabilities(),
          cmp_nvim_lsp.default_capabilities()
        ),
      }
      for server, server_opts in pairs(opts.enabled_servers) do
        local combined_opts = vim.tbl_deep_extend("force",
          server_opts,
          capabilities)
        lspconfig[server].setup(combined_opts)
      end
    end,

    opts = {
      enabled_servers = {
        -- keep-sorted start
        bashls = {},
        gopls = {},
        -- Used for PHP.
        intelephense = {},
        pylsp = {},
        ruff = {},
        vimls = {},
        -- keep-sorted end
      },
    }
  },
}
