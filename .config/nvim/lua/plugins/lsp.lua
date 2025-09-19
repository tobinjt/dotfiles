-- Note: some plugin configs also contain LSP config, e.g. lua.lua.
-- Note: until an LSP request is made, :LspInfo will show "no active clients".
-- Write the file to trigger autoformatting and attachment.
-- It sometimes takes 10+ seconds for the client to show up too.

-- Only enable a server if it's installed.
local make_enabled_servers = function()
  local servers = {
    -- keep-sorted start
    { name = "basedpyright", opts = {}, executable = "basedpyright" },
    { name = "bashls",       opts = {}, executable = "bash-language-server" },
    { name = "gopls",        opts = {}, executable = "gopls" },
    -- Used for PHP.
    { name = "intelephense", opts = {}, executable = "intelephense" },
    { name = "ruff",         opts = {}, executable = "ruff" },
    { name = "vimls",        opts = {}, executable = "vim-language-server" },
    -- keep-sorted end
  }
  local enabled_servers = {}
  for _, server in ipairs(servers) do
    if vim.fn.executable(server.executable) == 1 then
      enabled_servers[server.name] = server.opts
    end
  end

  return enabled_servers
end

return {
  {
    "neovim/nvim-lspconfig",
    -- My config requires Neovim 0.11 or later because it uses vim.lsp.config().
    cond = vim.fn.has("nvim-0.11") == 1,
    dependencies = {
      "cmp-nvim-lsp",
      "mason-lspconfig.nvim",
    },

    -- The servers to enable are collected in opts.enabled_servers with the
    -- server options if any.  Config required by cmp-nvim-lsp is added to the
    -- default server.
    config = function(_, opts)
      -- Enable for debugging.
      -- vim.lsp.set_log_level(vim.log.levels.DEBUG)

      -- Set default capabilities to what Neovim supports plus what completion
      -- supports.
      vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend("force",
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        ),
      })
      for server, server_opts in pairs(opts.enabled_servers) do
        -- Only configure the server if I have configuration, otherwise the
        -- defaults should be fine.
        if next(server_opts) ~= nil then
          vim.lsp.config(server, server_opts)
        end
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
          if client:supports_method("textDocument/completion") then
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
      enabled_servers = make_enabled_servers(),
    }
  },
}
