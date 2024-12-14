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

-- Recognise colon as a word separator.
-- https://wezfurlong.org/wezterm/config/lua/config/selection_word_boundary.html
config.selection_word_boundary = " \t\n{}[]()\"'`" .. ":"

return config
