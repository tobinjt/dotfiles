-- Docs at https://github.com/mfussenegger/nvim-dap-python are useful.
return {
  -- keep-sorted start block=yes

  {
    "jay-babu/mason-nvim-dap.nvim",
    -- Untested.
    enabled = false,
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },
  {
    "leoluz/nvim-dap-go",
    -- Untested.
    enabled = false,
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mrcjkb/rustaceanvim",
    enabled = false,
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
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
      "nvim-neotest/nvim-nio",
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
              "<leader>dg",
              function() require("dap").goto_() end,
              desc = "Go to Line (No Execute)"
            },

            {
              "<leader>di",
              function() require("dap").step_into() end,
              desc = "Step Into"
            },

            {
              "<leader>dj",
              function() require("dap").down() end,
              desc = "Down"
            },

            {
              "<leader>dk",
              function() require("dap").up() end,
              desc = "Up"
            },

            {
              "<leader>dl",
              function() require("dap").run_last() end,
              desc = "Run Last"
            },

            {
              "<leader>do",
              function() require("dap").step_out() end,
              desc = "Step Out"
            },

            {
              "<leader>dO",
              function() require("dap").step_over() end,
              desc = "Step Over"
            },

            {
              "<leader>dp",
              function() require("dap").pause() end,
              desc = "Pause"
            },

            {
              "<leader>dr",
              function() require("dap").repl.toggle() end,
              desc = "Toggle REPL"
            },

            {
              "<leader>ds",
              function() require("dap").session() end,
              desc = "Session"
            },

            {
              "<leader>dt",
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
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
    },
  },
  -- keep-sorted end
}
