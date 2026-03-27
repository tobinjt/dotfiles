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
    -- Automatically sets up LSP, so lsp.lua doesn't include rust.
    -- Makes debugging work seamlessly.
    "mrcjkb/rustaceanvim",
    version = "^8", -- Recommended by module.
    ft = "rust",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
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
    version = '*',
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
    -- Draws lines to indicate where indented blocks begin and end.
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
    "stevearc/aerial.nvim",
    config = true,
    cmd = {
      "AerialOpen",
      "AerialToggle",
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
  {
    'Wansmer/treesj',
    config = true,
    keys = {
      '<space>m',
      '<space>j',
      '<space>s',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- keep-sorted end
}
