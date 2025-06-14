local paths = require("paths")

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    cond = paths.exists(paths.gemini_api_key),
    build = "make",

    opts = {
      provider = "gemini",
      providers = {
        gemini = {
          model = "gemini-2.5-flash-preview-05-20",
        },
      },
    },

    -- Set the GEMINI_API_KEY environment variable from the file before loading
    -- the plugin.
    config = function(_, opts)
      local expanded_path = vim.fn.expand(paths.gemini_api_key)
      local api_key = vim.fn.readfile(expanded_path)[1]
      vim.fn.setenv("GEMINI_API_KEY", api_key)
      require("avante").setup(opts)
    end,

    dependencies = {
      -- Required.
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      --- Optional,
      "folke/snacks.nvim", -- for input provider snacks
      "hrsh7th/nvim-cmp",  -- autocompletion for avante commands and mentions
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = {
            "Avante",
            "markdown",
          },
        },
      },
    },
  }
}
