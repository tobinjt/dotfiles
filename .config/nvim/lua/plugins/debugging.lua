return {
  {
    "mfussenegger/nvim-dap",
  },

  -- keep-sorted start block=yes
  {
    "jay-babu/mason-nvim-dap.nvim",
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
  },
  {
    "mfussenegger/nvim-dap-python",
    opts = {},
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
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  -- keep-sorted end
}
