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

return {
  -- keep-sorted start block=true by_regex=".*"
  {
    -- Jumps to the last exited location in files.
    "farmergreg/vim-lastplace",
  },
  {
    -- VCS indicators in the signs column.
    "mhinz/vim-signify",
  },
  {
    -- Improved status bar.
    "nvim-lualine/lualine.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
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
    "shellRaining/hlchunk.nvim",
    cmd = {
      "DisableHLChunk",
      "DisableHLIndent",
      "EnableHLChunk",
      "EnableHLIndent",
    },
    opts = {
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
      }
    },
  },
  {
    -- Set the name of the tmux pane to the filename I'm editing.
    "tobinjt/TmuxSetWindowName.vim",
  },
  {
    -- Makes filename:line-number[:column] work.
    "wsdjeg/vim-fetch",
  },
  -- keep-sorted end
}
