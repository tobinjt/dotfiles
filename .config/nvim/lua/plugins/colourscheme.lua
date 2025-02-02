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
        -- ColorColumn: stop setting background colour, change style to italic
        -- so it stands out slightly.
        highlights.ColorColumn.bg = colors.none
        highlights.ColorColumn.italic = true
        -- Change line numbers from orange to white.
        highlights.LineNr.fg = colors.fg
      end,
    },
  },
}
