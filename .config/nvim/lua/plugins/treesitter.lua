local tools = require("johntobin.tools")

return {
  -- Syntax highlighting and more.
  {
    "nvim-treesitter/nvim-treesitter",
    -- Based on https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
    -- treesitter.setup() doesn't install parsers, instead we need
    -- treesitter.config.setup(opts).
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
    -- documents all this.

    main = "nvim-treesitter.configs",
    -- Rebuild parsers when the plugin is updated.
    build = ':TSUpdate',

    opts = {
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
      ensure_installed = tools.make_treesitter_parsers_to_install(),
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      -- :help nvim-treesitter-incremental-selection-mod
      -- Consider "nvim-treesitter/nvim-treesitter-textobjects" ?
    },
  },
}
