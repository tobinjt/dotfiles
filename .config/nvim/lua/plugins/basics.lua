return {
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        styles = {
          -- Unclear what effect this will have, we'll see.
            floats = "transparent"
        },
      })
      vim.cmd[[colorscheme solarized-osaka]]
    end
  }
}
