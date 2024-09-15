-- Copied from https://lazy.folke.io/installation
-- Bootstrap lazy.nvim.
require("config.lazy")
-- https://lazy.folke.io/usage/structuring
-- Load all the configs defined in lua/plugins/*.lua
require("lazy").setup("plugins")
vim.cmd.colorscheme('solarized8-mine')
-- Configure folding to use Treesitter.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
