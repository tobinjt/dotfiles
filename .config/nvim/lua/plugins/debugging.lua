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
    "mfussenegger/nvim-dap",
    -- lua require'dap'.continue()
    lazy = true,
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
    -- lua require("dapui").open()
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
