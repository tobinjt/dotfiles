-- Neovim is permanently on Lua 5.1, but everything else assumes a later Lua
-- version, and complains that `unpack` is deprecated and I should use
-- `table.unpack` instead, which doesn't exist in Lua 5.1, so create it.
-- This makes linters unhappy so we need to silence both luacheck and LSP.
-- https://luacheck.readthedocs.io/en/stable/inline.html
-- luacheck: ignore 122
---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack
-- luacheck: enable 122

-- Set options like `expandtab` as early as possible so that they apply to all
-- files opened.  Loading this from the plugins directory results in a weird
-- situation where the *first* file opened has the correct settings, but
-- subsequent files opened do not.
require("johntobin.settings")
-- Settings that are required before loading plugins.
require("johntobin.paths").load_gemini_api_key()
-- Copied from https://lazy.folke.io/installation
-- Bootstrap lazy.nvim.
require("johntobin.lazy-bootstrap")
-- Load all the configs defined in lua/plugins/*.lua
require("johntobin.lazy-config")

-- Highlight column after textwidth.
require("johntobin.colorcolumn")

-- Some config that doesn't really fit elsewhere.
vim.cmd.colorscheme("solarized-osaka")
local testing_colorschemes = {
  -- keep-sorted start
  "NeoSolarized",
  "bamboo",
  "solarized-osaka",
  "tokyonight-night",
  -- keep-sorted end
}
math.randomseed()
local index = math.random(1, #testing_colorschemes)
vim.cmd.colorscheme(testing_colorschemes[index])

-- Configure folding to use Treesitter.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Put a border around popup windows.
if vim.fn.exists("&winborder") == 1 then
  vim.o.winborder = 'rounded'
end
-- Support local config.  If the file doesn't exist this will fail quietly, and
-- if it does exist the file will be loaded.  All setup needs to be done as part
-- of loading - we don't call setup() or similar.
pcall(require, "johntobin.local")
-- Compile spell file *after* local config is loaded so vim.opt.spellfile can be
-- changed.
require("johntobin.functions").UpdateSpellfilesIfNecessary()
