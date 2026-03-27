-- Note: until an LSP request is made, :LspInfo will show "no active clients".
-- Write the file to trigger autoformatting and attachment.
-- It sometimes takes 10+ seconds for the client to show up too.

local tools = require("johntobin.tools")

return {
  {
    "neovim/nvim-lspconfig",
    -- My config requires Neovim 0.11 or later because it uses vim.lsp.config().
    cond = vim.fn.has("nvim-0.11") == 1,
    dependencies = {
      "folke/neoconf.nvim",
      "mason-org/mason-lspconfig.nvim",
      -- Definitions for busted functions so LuaLS recognises them.  Doesn't add
      -- anything to Neovim.  Will be added to runtimepath, but shouldn't cause
      -- any issues.
      "LuaCATS/busted",
    },

    -- The servers to enable are collected in opts.enabled_servers with the
    -- server options if any.  Config required by cmp-nvim-lsp is added to the
    -- default server.
    config = function(_, opts)
      -- Enable for debugging.
      -- vim.lsp.set_log_level(vim.log.levels.DEBUG)

      for server, server_opts in pairs(opts.enabled_servers) do
        -- Only configure the server if I have configuration, otherwise the
        -- defaults should be fine.
        if server_opts.server_opts ~= nil then
          vim.lsp.config(server, server_opts.server_opts)
        end
        vim.lsp.enable(server)
      end

      -- Disable LSP servers I don't want in work. This is easier than
      -- overriding make_lsp_enabled_servers().
      vim.lsp.enable(opts.disabled_servers, false)

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
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client:supports_method("textDocument/completion") then
            -- Enable ^X-^O completion.
            vim.lsp.completion.enable(
              true,
              client.id,
              args.buf,
              { autotrigger = false })
            vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          end

          if client:supports_method("textDocument/signatureHelp") then
            local enable = false
            local config = (opts.enabled_servers[client.name] or {})
            local config_opts = config.config_opts or { inlay_hint = true }
            if config_opts.inlay_hint then
              enable = true
            end
            if vim.list_contains(config_opts.inlay_hint_filetypes or {},
                  vim.bo[args.buf].filetype) then
              enable = true
            end
            if enable then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end
        end,
      })
    end,

    opts = {
      enabled_servers = tools.make_lsp_enabled_servers(),
      -- A way to disble servers in work.
      disabled_servers = {},
    }
  },
}
