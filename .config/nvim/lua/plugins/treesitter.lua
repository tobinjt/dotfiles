return {
  -- Syntax highlighting and more.
  {
    "nvim-treesitter/nvim-treesitter",
    -- Based on https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
    -- treesitter.setup() doesn't install parsers, instead we need
    -- treesitter.config.setup(opts).
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
      ensure_installed = {
        "bash",
        "go",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "vim",
        "vimdoc",
      },
    },
  },
}
