return {
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    opts = {
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },

      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        local config = require("solarized-osaka.config")
        -- ColorColumn: stop setting background colour, change style to match
        -- comments so it stands out slightly.
        highlights.ColorColumn.bg = colors.none
        highlights.ColorColumn.style = config.options.styles.comments
        -- Change line numbers from orange to white.
        highlights.LineNr.fg = colors.fg
      end,
    },
  },

  {
    dir = vim.fn.expand("~/.vim/bundle/vim-solarized8"),
    priority = 1000,
    lazy = false,
  },

}
