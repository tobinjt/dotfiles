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
          -- https://ai.google.dev/gemini-api/docs/models
          model = "gemini-2.5-flash",
        },
      },
    },

    -- Set the GEMINI_API_KEY environment variable from the file before loading
    -- the plugin.
    config = function(_, opts)
      local expanded_path = vim.fn.expand(paths.gemini_api_key)
      local api_key = vim.fn.readfile(expanded_path)[1]
      vim.fn.setenv("AVANTE_GEMINI_API_KEY", api_key)
      require("avante").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Disable folding for Avante windows, it hides the AI responses",
        group = "johntobin",
        pattern = "Avante",
        callback = function(_)
          vim.opt_local.foldenable = false
        end,
      })
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
