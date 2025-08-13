return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = {
      "markdown",
    },
    opts = {
      code = {
        -- Stop showing a white bar at the top of code blocks.
        language_border = " ",
      },
      -- Enable completion, I don't know what this will do.
      completions = {
        lsp = {
          enabled = true
        }
      },
    }
  },
}
