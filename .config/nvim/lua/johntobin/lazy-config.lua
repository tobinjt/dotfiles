-- Load all the configs defined in lua/plugins/*.lua
-- https://lazy.folke.io/usage/structuring
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    -- Stop telling me that a package spec was reloaded.
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- I find the bouncing between braces really distracting.
        "matchparen",
        -- Creates a history file I don't want.
        "netrwPlugin",
        -- Plugins I don't use.
        -- keep-sorted start
        "editorconfig",
        "gzip",
        "man",
        "rplugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        -- keep-sorted end
      },
    },
  },
})
