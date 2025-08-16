local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance.
-- Hide the title bar to give more vertical space.
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

-- Font configuration.
config.font = wezterm.font('Inconsolata')
config.font_size = 14

-- Colour scheme.
-- Copied manually from iTerm2's Solarized theme.
config.colors = {
  -- The default text color
  foreground = '#869395',
  -- The default background color
  background = '0d2a34',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#869395',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#163540',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#beeafc',

  -- the foreground color of selected text
  selection_fg = '#95a0a0',
  -- the background color of selected text
  selection_bg = '#163540',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',

  ansi = {
    '#163540',
    '#ca4238',
    '#88982d',
    '#ae8a2c',
    '#4689cc',
    '#c24380',
    '#519e97',
    '#ece8d6',
  },
  brights = {
    '#0d2a34',
    '#bc5329',
    '#5c6d74',
    '#697a81',
    '#869395',
    '#6c70be',
    '#95a0a0',
    '#fbf6e4',
  },
}

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

-- Mouse bindings.
-- Copied from https://wezfurlong.org/wezterm/config/mouse.html#configuring-mouse-assignments
-- and cleaned up.
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects text and doesn't
  -- open hyperlinks.
  {
    event = {
      Up = {
        streak = 1,
        button = 'Left'
      }
    },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('ClipboardAndPrimarySelection'),
  },

  -- And make CMD-Click open hyperlinks.
  {
    event = {
      Up = {
        streak = 1,
        button = 'Left'
      }
    },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}


-- Recognise extra characters as word separators.
-- https://wezfurlong.org/wezterm/config/lua/config/selection_word_boundary.html
config.selection_word_boundary = ' \t\n{}[]()"\'`' .. ':,=*'

local config_file_found, function_to_call = pcall(require, "local")
if config_file_found then
  function_to_call(config)
end

return config
