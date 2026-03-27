local tools = require("johntobin.tools")

return {
  -- Syntax highlighting and more.
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = tools.make_treesitter_parsers_to_install(),
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}
