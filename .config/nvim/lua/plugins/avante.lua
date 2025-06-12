local paths = require("paths")

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    cond = paths.exists("~/.config/gemini/api_key"),
    opts = {
      provider = "gemini",
      providers = {
        gemini = {
          model = "gemini-2.5-flash-preview-05-20",
        },
      },
    },
    build = "make",
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
