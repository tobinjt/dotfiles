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
