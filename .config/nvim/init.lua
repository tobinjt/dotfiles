-- Neovim is permanently on Lua 5.1, but everything else assumes a later Lua
-- version, and complains that `unpack` is deprecated and I should use
-- `table.unpack` instead, which doesn't exist in Lua 5.1, so create it.
---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

-- Copied from https://lazy.folke.io/installation
-- Bootstrap lazy.nvim.
require("config.lazy")
-- https://lazy.folke.io/usage/structuring
-- Load all the configs defined in lua/plugins/*.lua
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  change_detection = {
    -- Stop telling me that a package spec was reloaded.
    notify = false,
  },
})

-- Some config that doesn't really fit elsewhere.
vim.cmd.colorscheme("solarized-osaka")
-- Configure folding to use Treesitter.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
