return {
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    opts = {
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      }
    },
  },
  {
    dir = vim.fn.expand("~/.vim/bundle/vim-solarized8"),
    priority = 1000,
    lazy = false,
  }
}
