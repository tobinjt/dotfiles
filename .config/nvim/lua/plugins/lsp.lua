-- Note: some plugin configs also contain LSP config, e.g. lua.lua.
return {
  {
    "neovim/nvim-lspconfig",
    -- My config requires Neovim 0.11 or later because it uses vim.lsp.config().
    cond = vim.fn.has("nvim-0.11") == 1,
    -- Dependencies are not necessary in other configs, setting them once is
    -- enough.
    dependencies = {
      "cmp-nvim-lsp",
      "mason-lspconfig.nvim",
    },

    -- The servers to enable are collected in opts.enabled_servers with the
    -- server options if any.  Config required by cmp-nvim-lsp is added
    -- automatically.
    -- require("lspconfig").start() doesn't exist so don't call it.
    config = function(_, opts)
      local capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )
      for server, server_opts in pairs(opts.enabled_servers) do
        local combined_opts = vim.tbl_deep_extend("force",
          server_opts,
          { capabilities = capabilities })
        vim.lsp.config(server, combined_opts)
        vim.lsp.enable(server)
      end

      -- Configure how diagnostics are displayed.
      vim.diagnostic.config(
        {
          -- Show diagnostic messages at the end of lines.
          virtual_text = true,
          -- But for the current line use virtual lines underneath so I can see
          -- multiple diagnostic messages.
          virtual_lines = {
            current_line = true,
          },
        }
      )

      -- https://gpanders.com/blog/whats-new-in-neovim-0-11/#builtin-auto-completion
      -- LSP autocompletion.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client == nil then
            return
          end
          -- Support Neovim < 0.11.
          if vim.lsp["completion"] == nil then
            return
          end
          if client.supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
              true,
              client.id,
              ev.buf,
              { autotrigger = false })
          end
        end,
      })
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
