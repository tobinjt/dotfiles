-- Docs at https://github.com/mfussenegger/nvim-dap-python are useful.
local paths = require("johntobin.paths")

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
      -- Consider the mappings at
      -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#mappings
      {
        "<leader>dt",
        function()
          if vim.bo[0].filetype == "go" then
            require("dap-go").debug_test()
          elseif vim.bo[0].filetype == "python" then
            require("dap-python").test_method()
          else
            vim.print("No test support for " .. vim.bo[0].filetype)
          end
        end,
        desc = "Debug the test method above the cursor"
      },
    },
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        -- Alternative UI.  https://igorlfs.github.io/nvim-dap-view/keymaps
        -- Load with :DapViewOpen
        -- Use g? in windows to see keymaps.
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {},
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
      },
      {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        cond = paths.installer_is_available_function("luarocks")(),
        config = function()
          -- debugpy is installed in my standard Python virtualenv so that it's
          -- available with all the other modules.
          require("dap-python").setup("python3")
        end,
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
