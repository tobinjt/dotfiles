-- Neovim is permanently on Lua 5.1, but everything else assumes a later Lua
-- version, and complains that `unpack` is deprecated and I should use
-- `table.unpack` instead, which doesn't exist in Lua 5.1, so create it.
-- This makes linters unhappy so we need to silence both luacheck and LSP.
-- https://luacheck.readthedocs.io/en/stable/inline.html
-- luacheck: ignore 122
---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack
-- luacheck: enable 122

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

-- Auto-install tools.
require("config.autoinstall")
-- Highlight column after textwidth.
require("config.colorcolumn")

-- Some config that doesn't really fit elsewhere.
vim.cmd.colorscheme("solarized-osaka")
-- Configure folding to use Treesitter.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Support local config.  If the file doesn't exist this will fail quietly, and
-- if it does exist the file will be loaded.  All setup needs to be done as part
-- of loading - we don't call setup() or similar.
pcall(require, "config.local")
