local paths = require("johntobin.paths")

return {
  {
    "yetone/avante.nvim",
    version = false, -- Never set this value to "*"! Never!
    cond = paths.exists(paths.gemini_api_key),
    build = "make",
    cmd = {
      "AvanteChat",
      "AvanteChatNew",
      "AvanteClear",
    },

    opts = {
      provider = "gemini",
      providers = {
        gemini = {
          -- https://ai.google.dev/gemini-api/docs/models
          model = "gemini-2.5-pro",
        },
      },

      -- This is used as the default provider for auto-suggestions.
      -- It is very slow - like 10s of seconds sometimes - and it sometimes
      -- breaks rate-limits, so I have disabled it.
      -- auto_suggestions_provider = "gemini",
      -- behaviour = {
      --   auto_suggestions = true,
      -- },
    },

    -- Set the AVANTE_GEMINI_API_KEY environment variable from the file before
    -- loading the plugin.
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
      {
        "folke/snacks.nvim", -- for input provider snacks
        priority = 1000,
        lazy = false,
        opts = {
          picker = { enabled = true },
        },
      },
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
