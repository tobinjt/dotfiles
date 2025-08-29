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
    },
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        -- Alternative UI.  https://igorlfs.github.io/nvim-dap-view/keymaps
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
          -- Automatically toggle dap-view windows when starting/stopping a
          -- session by pressing continue.
          auto_toggle = true,
        },
      },
    }
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
          automatic_installation = false,
          -- DAP servers: these will be installed by mason-tool-installer.nvim
          -- for consistency.
          ensure_installed = {},
        },
        dependencies = {
          "mfussenegger/nvim-dap",
          "mason-org/mason.nvim",
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
            function() require("dap-go").debug_test() end,
            desc = "Debug test"
          },
        },
      },
      {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        config = function()
          -- debugpy is installed in my standard Python virtualenv so that it's
          -- available with all the other modules.
          require("dap-python").setup("python3")
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
