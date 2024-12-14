local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Colour scheme.
config.color_scheme = 'Solarized (dark) (terminal.sexy)'

-- Font configuration.
config.font = wezterm.font(
  "Inconsolata",
  {
    weight = "Regular",
    stretch = "Normal",
    style = "Normal",
  })
config.font_size = 15

-- Key bindings.
config.keys = {
  {
    -- CMD-left-arrow moves one tab left.
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action.ActivateTabRelative(-1),
  },

  {
    -- CMD-right-arrow moves one tab right.
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action.ActivateTabRelative(1),
  },

}

-- Recognise colon as a word separator.
-- https://wezfurlong.org/wezterm/config/lua/config/selection_word_boundary.html
config.selection_word_boundary = " \t\n{}[]()\"'`" .. ":"

return config
