-- Docs at https://github.com/mfussenegger/nvim-dap-python are useful.
return {
  -- keep-sorted start block=yes

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
    -- modified.
    keys = {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc = "Breakpoint Condition"
      },

      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint"
      },

      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue"
      },

      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor"
      },

      {
        "<leader>dT",
        function() require("dap").terminate() end,
        desc = "Terminate"
      },

      {
        "<leader>dw",
        function() require("dap.ui.widgets").hover() end,
        desc = "Widgets"
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI"
      },
    },
    dependencies = {
      -- keep-sorted start block=yes
      {
        "jay-babu/mason-nvim-dap.nvim",
        ---@type MasonNvimDapSettings
        opts = {
          -- This line is essential to making automatic installation work
          -- :exploding-brain
          handlers = {},
          automatic_installation = {
            exclude = {
              "delve",
              "python",
            },
          },
          ensure_installed = {
            "bash",
            "codelldb",
            "php",
          },
        },
        dependencies = {
          "mfussenegger/nvim-dap",
          "williamboman/mason.nvim",
        },
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
        dependencies = {
          "mfussenegger/nvim-dap",
        },
        keys = {
          {
            "<leader>dt",
            function() require('dap-go').debug_test() end,
            desc = "Terminate"
          },
        },
      },
      {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        config = function()
          local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
          require("dap-python").setup(python)
        end,
        -- Consider the mappings at
        -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#mappings
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      {
        "nvim-neotest/nvim-nio",
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      -- keep-sorted end
    },
  },
  -- keep-sorted end
}
