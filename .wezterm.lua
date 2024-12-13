local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Solarized (dark) (terminal.sexy)'
config.font = wezterm.font(
  "Inconsolata",
  {
    weight = "Regular",
    stretch = "Normal",
    style = "Normal",
  })
config.font_size = 15

return config
