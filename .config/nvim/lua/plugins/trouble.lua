return {
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        -- This doesn't seem to do anything?
        lsp = {
          win = { position = "right" },
        },

        -- https://github.com/folke/trouble.nvim/blob/main/docs/examples.md#diagnostics-cascade
        -- Filter for the worst class of errors first, and when they're resolved
        -- move on to the next class of errors.
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },

      },
    },

    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)"
      },
    },
  }
}
