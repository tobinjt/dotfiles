return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- keep-sorted start
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      -- keep-sorted end
    },

    ---@type cmp.ConfigSchema
    opts = {
      ---@type cmp.SourceConfig[]
      sources = {
        -- Order determines the order they're presented in completion results.
        -- Try using :help cmp-config.sources[n].group_index
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
      },

      completion = {
        autocomplete = false,
      },
      mapping = {
        -- Keymappings:
        -- - Tab starts completion, and moves to the next completion item.
        -- - Enter selects the current completion item.
        -- - K shows documentation window (standard Neovim config, not
        --   configured here).
        -- Copied from `:help cmp-mapping`.
        ['<CR>'] = function(fallback)
          local cmp = require('cmp')
          if cmp.visible() then
            cmp.confirm()
          else
            fallback()
          end
        end,

        -- Copied from https://www.lazyvim.org/configuration/recipes#supertab
        -- and heavily modified.
        ["<Tab>"] = function(fallback)
          local has_words_before = function()
            ---@diagnostic disable-next-line: deprecated
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            if col == 0 then
              return false
            end
            -- https://neovim.io/doc/user/api.html#nvim_buf_get_lines()
            local line_contents = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
            local character_at_cursor = line_contents:sub(col, col)
            return character_at_cursor:match("%s") == nil
          end

          local cmp = require("cmp")
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end,

        ["<S-Tab>"] = function(fallback)
          local cmp = require("cmp")
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
    },
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = {
      "mason-lspconfig.nvim",
    },
  },
}
