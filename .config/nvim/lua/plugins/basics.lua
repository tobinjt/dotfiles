-- Airline. Change the status line so it doesn't need symbols missing from some
-- fonts.
vim.g.airline_symbols_ascii = 1

-- Signify.
-- Disable VCS systems I don't use.
vim.g.signify_skip = {
  vcs = {
    allow = {
      "git",
      "hg",
      "perforce",
    },
  },
}

-- Disable indentscope by default.
vim.g.miniindentscope_disable = true

return {
  -- keep-sorted start block=true by_regex=".*"
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      draw = {
        -- Copied from MiniIndentscope.gen_animation.none().
        animation = function() return 0 end,
      },
    },
  },
  {
    -- Jumps to the last exited location in files.
    "farmergreg/vim-lastplace",
  },
  {
    -- VCS indicators in the signs column.
    "mhinz/vim-signify",
  },
  {
    -- Finding various things, I need to experiment.
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  },
  {
    -- Fancy icons.  Needs a font supporting those icons, typically nerdfont.
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    -- Set the name of the tmux pane to the filename I'm editing.
    "tobinjt/TmuxSetWindowName.vim",
  },
  {
    -- Improved status bar.
    "vim-airline/vim-airline",
  },
  {
    -- Makes filename:line-number[:column] work.
    "wsdjeg/vim-fetch",
  },
  -- keep-sorted end
}
