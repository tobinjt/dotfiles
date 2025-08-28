local paths = require("johntobin.paths")

-- Create but do not clear the augroup rather than relying on it being created
-- elsewhere.
vim.api.nvim_create_augroup("johntobin", { clear = false })
vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable folding for Avante windows, it hides the AI responses",
  group = "johntobin",
  pattern = "Avante",
  callback = function(_)
    vim.opt_local.foldenable = false
  end,
})

return {
  {
    "yetone/avante.nvim",
    version = false, -- Never set this value to "*"! Never!
    cond = paths.exists(paths.gemini_api_key_path),
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
    },

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
